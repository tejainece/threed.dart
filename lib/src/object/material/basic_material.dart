import 'dart:web_gl';

import 'package:threed/src/object/material/material.dart';
import 'package:threed/src/renderer/webgl/program.dart';

class BasicMaterial implements Material {
  bool visible;

  WebglProgram buildProgram(RenderingContext2 context) {
    return WebglProgram.build(
        context: context, vertex: vertexShader, fragment: fragmentShader);
  }

  void setUniforms(CommonUniforms uniforms) {
    // TODO
  }

  void useFor() {
    // TODO set uniforms

    // TODO set attributes
  }
}

const vertexShader = """
uniform mat4 modelMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat3 normalMatrix;
uniform vec3 cameraPosition;
uniform bool isOrthographic;

#ifdef USE_INSTANCING
  attribute mat4 instanceMatrix;
#endif

attribute vec3 position;
attribute vec3 normal;
attribute vec2 uv;

 // TODO tangent
 
 // TODO use color
 
 // TODO morphtargets
 // TODO skinning

// TODO
// TODO declare vColor if needed
// TODO

void main() {
  // TODO UV
  // TODO UV2
  // TODO vertex color
  // TODO skinbase

  vec3 transformed = vec3( position );
  // TODO morph targets
  // TODO skinning
  vec4 mvPosition = vec4( transformed, 1.0 );
  #ifdef USE_INSTANCING // TODO
  mvPosition = instanceMatrix * mvPosition;
  #endif
  mvPosition = modelViewMatrix * mvPosition;
  gl_Position = projectionMatrix * mvPosition;
  // TODO logdepthbuf

  // TODO
}
""";

// TODO logdepth
// TODO specularmap
// TODO aomap
// TODO envmap
const fragmentShader = """
uniform vec3 diffuse;
uniform float opacity;
#ifndef FLAT_SHADED
	varying vec3 vNormal;
#endif

#ifdef USE_COLOR
	varying vec3 vColor;
#endif
#if ( defined( USE_UV ) && ! defined( UVS_VERTEX_ONLY ) )
	varying vec2 vUv;
#endif
#if defined( USE_LIGHTMAP ) || defined( USE_AOMAP )
	varying vec2 vUv2;
#endif
#ifdef USE_MAP
	uniform sampler2D map;
#endif
#ifdef USE_ALPHAMAP
	uniform sampler2D alphaMap;
#endif
// TODO aomap
#ifdef USE_LIGHTMAP
	uniform sampler2D lightMap;
	uniform float lightMapIntensity;
#endif
// TODO envmap_common
// TODO envmap
#ifdef USE_FOG
	uniform vec3 fogColor;
	varying float fogDepth;
	#ifdef FOG_EXP2
		uniform float fogDensity;
	#else
		uniform float fogNear;
		uniform float fogFar;
	#endif
#endif
// TODO specular
// TODO logdepth
// TODO clipping_planes
// TODO

void main() {
  // TODO clipping_planes
  
  vec4 diffuseColor = vec4( diffuse, opacity );
  
  // TODO logdepthbuf_fragment
#ifdef USE_MAP
	vec4 texelColor = texture2D( map, vUv );
	texelColor = mapTexelToLinear( texelColor );
	diffuseColor *= texelColor;
#endif
#ifdef USE_COLOR
	diffuseColor.rgb *= vColor;
#endif
#ifdef USE_ALPHAMAP
	diffuseColor.a *= texture2D( alphaMap, vUv ).g;
#endif
#ifdef ALPHATEST
	if ( diffuseColor.a < ALPHATEST ) discard;
#endif
  // TODO specularmap
  
  ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );

	// accumulation (baked indirect lighting only)
	#ifdef USE_LIGHTMAP
		reflectedLight.indirectDiffuse += texture2D( lightMap, vUv2 ).xyz * lightMapIntensity;
	#else
		reflectedLight.indirectDiffuse += vec3( 1.0 );
	#endif

  // TODO aomap
  
  reflectedLight.indirectDiffuse *= diffuseColor.rgb;
	vec3 outgoingLight = reflectedLight.indirectDiffuse;
  
  // TODO envmap
  
  gl_FragColor = vec4( outgoingLight, diffuseColor.a );
  
#ifdef PREMULTIPLIED_ALPHA
	// Get get normal blending with premultipled, use with CustomBlending, OneFactor, OneMinusSrcAlphaFactor, AddEquation.
	gl_FragColor.rgb *= gl_FragColor.a;
#endif
#if defined( TONE_MAPPING )
	gl_FragColor.rgb = toneMapping( gl_FragColor.rgb );
#endif
  gl_FragColor = gl_FragColor;  // TODO use encoding function
#ifdef USE_FOG
	#ifdef FOG_EXP2
		float fogFactor = 1.0 - exp( - fogDensity * fogDensity * fogDepth * fogDepth );
	#else
		float fogFactor = smoothstep( fogNear, fogFar, fogDepth );
	#endif
	gl_FragColor.rgb = mix( gl_FragColor.rgb, fogColor, fogFactor );
#endif
}
""";
