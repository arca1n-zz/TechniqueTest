uniform sampler2D colorSampler;
uniform sampler2D noiseSampler;
uniform sampler2D depthSampler;
varying vec2 uv;

void main() {
    //vec2 displacement = texture2D(noiseSampler, uv).rg - vec2(0.5, 0.5);
    vec4 depthColor = texture2D(depthSampler, uv);
    vec4 color = texture2D(colorSampler, uv );
    if (color.x == 0.1 && color.y == 0.1 && color.z == 0.1) {
        discard;
    }else {
        gl_FragColor = color;
    }
    //gl_FragColor = color;
    //gl_FragColor = texture2D(colorSampler, uv + displacement * vec2(0.1,0.1));
    //gl_FragColor = vec4(1, 0, 0, 1);
}