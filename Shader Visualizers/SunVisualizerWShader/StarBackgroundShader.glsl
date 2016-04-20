#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertTexCoord;
varying vec4 vertColor;

// This function is executed for every pixel;
// The purpose of this is to set gl_FragColor for the GPU;
void main()
{
    gl_FragColor = vertColor;
}