uniform float uTime;
void main() {
    vec3 color = vec3(sin(uTime));    // color = color1;
    gl_FragColor = vec4(color,1.0);
}