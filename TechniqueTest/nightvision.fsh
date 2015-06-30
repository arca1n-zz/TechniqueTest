uniform sampler2D colorSampler;
uniform sampler2D noiseSampler;
uniform sampler2D depthSampler;
varying vec2 v_texCoord;
uniform sampler2D maskSampler;
uniform float elapsedTime; // seconds

void main ()
{
    float luminanceThreshold = 0.2; // 0.2
    float colorAmplification = 4.0; // 4.0
    float effectCoverage = 1.0; // 0.5
    vec4 finalColor;
    // Set effectCoverage to 1.0 for normal use.
    if (v_texCoord.x < effectCoverage)
    {
        vec2 uv;
        uv.x = 0.4*sin(elapsedTime*50.0);
        uv.y = 0.4*cos(elapsedTime*50.0);
        float m = texture2D(maskSampler, v_texCoord.st).r;
        vec3 n = texture2D(noiseSampler,
                           (v_texCoord.st*3.5) + uv).rgb;
        vec3 c = texture2D(colorSampler, v_texCoord.st
                           + (n.xy*0.005)).rgb;
        
        float lum = dot(vec3(0.30, 0.59, 0.11), c);
        if (lum < luminanceThreshold)
            c *= colorAmplification;
        
        vec3 visionColor = vec3(0.1, 0.95, 0.2);
        finalColor.rgb = (c + (n*0.2)) * visionColor * m;
    }
    else
    {
        finalColor = texture2D(colorSampler,
                               v_texCoord.st);
    }
    gl_FragColor.rgb = finalColor.rgb;
    gl_FragColor.a = 1.0;
}