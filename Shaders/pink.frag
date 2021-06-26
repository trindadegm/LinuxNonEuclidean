#version 150
precision highp float;

//Inputs
uniform sampler2D tex;

//Outputs
//out vec4 gl_FragColor;
out vec4 fragColor;

void main(void) {
	//gl_FragColor = vec4(1.0, 0.0, 1.0, 1.0);
	fragColor = vec4(1.0, 0.0, 1.0, 1.0);
}
