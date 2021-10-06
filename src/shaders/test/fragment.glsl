uniform float uTime;
varying vec3 vPosition;

float random (in vec2 st) {
        return fract(sin(dot(st.xy,
        vec2(12.9898,78.233)))*
        43758.5453123);
    }
    // Quilez's 2D simplex noise https://www.shadertoy.com/view/Msf3WH
    // originally had issue with tiling, but Mike Bostock's sketch and the book of shaders chapter on noise helped me figure it out
    // https://observablehq.com/@mbostock/domain-warping
    vec2 hash( vec2 p ) // replace this by something better
    {
        p = vec2( dot(p,vec2(127.1,311.7)), dot(p,vec2(269.5,183.3)) );
        return -1.0 + 2.0*fract(sin(p)*43758.5453123);
    }
    float noise( in vec2 p )
    {
        const float K1 = 0.366025404; // (sqrt(3)-1)/2;
        const float K2 = 0.211324865; // (3-sqrt(3))/6;

        vec2  i = floor( p + (p.x+p.y)*K1 );
        vec2  a = p - i + (i.x+i.y)*K2;
        float m = step(a.y,a.x);
        vec2  o = vec2(m,1.0-m);
        vec2  b = a - o + K2;
        vec2  c = a - 1.0 + 2.0*K2;
        vec3  h = max( 0.5-vec3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );
        vec3  n = h*h*h*h*vec3( dot(a,hash(i+0.0)), dot(b,hash(i+o)), dot(c,hash(i+1.0)));
        return dot( n, vec3(70.0) );
    }
        #define OCTAVES 6
    float fbm (in vec2 st) {
        // Initial values
        float value = 0.0;
        float amplitude = .5;
        float frequency = 0.;
        //
        // Loop of octaves
        for (int i = 0; i < OCTAVES; i++) {
            value += amplitude * noise(st);
            st *= 2.;
            amplitude *= .5;
        }
        return value;
    }

void main() {
    vec2 p = vPosition.xz / 100.0;
    float s = fbm(p + uTime * -0.03);
    float r = fbm(s + p + uTime * 0.1);
    vec3 color = vec3(0.0);
    color += fbm(p + r + uTime/10.0);
    color.r += s;
    color.g += r;
    color += 0.1;

    gl_FragColor = vec4(color,1.0);
}