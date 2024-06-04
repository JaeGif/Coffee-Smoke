uniform float uTime;
uniform sampler2D uPerlinTexture;

varying vec2 vUv;

#include ../includes/rotate2D.glsl
// this include is from the vite glsl plugin

void main () {

    // want the vertices to rotate around the xz plane so it's not a fixed plane of smoke
    vec3 newPosition = position;
    float angle = 10.0;
    // can add some randomness by using perlin to control the twist
    float twistPerlin = texture(uPerlinTexture, vec2(0.5, uv.y * 0.3 - uTime * 0.015)).r;
    angle *= twistPerlin;

    newPosition.xz = rotate2D(newPosition.xz, angle); // rotates whole plane

    vec2 windOffset = vec2(
        texture(uPerlinTexture, vec2(0.2, uTime * 0.01)).r - 0.5, 
        texture(uPerlinTexture, vec2(0.8, uTime * 0.01)).r - 0.5
        );
    windOffset *= pow(uv.y, 2.5) * 10.0;  // anchor at y = 0


    newPosition.xz += windOffset;
    // final position
    // order when doing matrix tranformations matters
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);

    vUv = uv;
}