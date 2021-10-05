uniform float uTime;

void main() {    
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    vec4 newModelPosition = modelPosition;
    newModelPosition.y += 2. * sin(uTime + newModelPosition.x/3.0);
    vec4 viewPosition = viewMatrix * newModelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;
    gl_PointSize = 5.0;
}