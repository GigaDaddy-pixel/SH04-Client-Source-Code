#version 120

uniform vec2 location;
uniform vec2 size;
uniform vec4 color;
uniform float radius;

float roundedBoxSDF(vec2 centerPos, vec2 size, float radius) {
    return length(max(abs(centerPos) - size + radius, 0.0)) - radius;
}

void main() {
    vec2 pos = gl_FragCoord.xy;
    vec2 center = location + size / 2.0;
    float distance = roundedBoxSDF(pos - center, size / 2.0, radius);
    float smoothedAlpha = 1.0 - smoothstep(0.0, 1.0, distance);

    if (smoothedAlpha <= 0.0) {
        discard;
    }

    gl_FragColor = vec4(color.rgb, color.a * smoothedAlpha);
}