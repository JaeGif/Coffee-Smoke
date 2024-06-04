uniform sampler2D uPerlinTexture;
uniform float uTime;
varying vec2 vUv;

void main() {
    // scale and animate
    vec2 smokeUv = vUv;
    smokeUv.x *= 0.5;
    smokeUv.y *= 0.3;
    smokeUv.y -= uTime * 0.04;

    // smoke
    float smoke = texture(uPerlinTexture, smokeUv).r;
    // remap using smoothstep instead of clamp (for smooth transition)
    smoke = smoothstep(0.4, 1.0, smoke);

    // fade so the edges dont exist
    smoke *= smoothstep(0.0, 0.1, vUv.x);
    smoke *= smoothstep(0.0, 0.1, 1.0 - vUv.x);

    smoke *= smoothstep(0.0, 0.3, vUv.y);
    smoke *= smoothstep(0.0, 0.7, 1.0 - vUv.y);

    // final color
    gl_FragColor = vec4(1.0, 1.0, 1.0, smoke);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>

}