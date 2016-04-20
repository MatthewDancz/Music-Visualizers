colorvert.glsl

#define PROCESSING_COLOR_SHADER

uniform mat4 transform;

attribute vec4 vertex;
attribute vec4 color;

varying vec4 vertColor;

void main()
{
	gl_Position = transform * vertex;
	vertColor = color;
}

colorfrag.glsl

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;

void main()
{
	gl_FragColor = vertColor;
}