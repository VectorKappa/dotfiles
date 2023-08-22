// The Nord colorscheme is used by default, 
// but you can make your own by changing `colors`

uniform float opacity;
uniform float time;
uniform bool invert_color;
uniform sampler2D tex;

float sin_rand() {
  return sin(gl_FragCoord.x + cos(gl_FragCoord.y));
}

float random(float seedChange) {
  vec2 seed = gl_FragCoord.xy + sin(seedChange);
  return fract(dot(vec2(sin(mod(seed.x / cos(seed.y), 5.0) * 10000.0)), vec2(1.1, 12.2)));
}

void main() {
  vec4 c = texture2D(tex, gl_TexCoord[0].xy);
  vec4 d = c;
  vec3 colors[16];
    colors[0 ] = vec3(0.286,0.302,0.392);
    colors[1 ] = vec3(0.929,0.529,0.588);
    colors[2 ] = vec3(0.651,0.855,0.584);
    colors[3 ] = vec3(0.933,0.831,0.624);
    colors[4 ] = vec3(0.541,0.678,0.957);
    colors[5 ] = vec3(0.961,0.741,0.902);
    colors[6 ] = vec3(0.545,0.835,0.792);
    colors[7 ] = vec3(0.722,0.753,0.878);
    colors[8 ] = vec3(0.357,0.376,0.471);
    colors[9 ] = vec3(0.926,0.529,0.588);
    colors[10] = vec3(0.651,0.855,0.584);
    colors[11] = vec3(0.933,0.831,0.624);
    colors[12] = vec3(0.541,0.678,0.957);
    colors[13] = vec3(0.961,0.741,0.902);
    colors[14] = vec3(0.545,0.835,0.792);
    colors[15] = vec3(0.647,0.678,0.796);
 
  float mindist = 100.0;
  int minind = 0;
  float mindist2 = 100.0;
  int minind2 = 0;
  for (int i = 0; i < 16; i++) {
    float dist = length(c.xyz - colors[i]);
    if (dist < mindist) {
      mindist2 = mindist;
      mindist = dist;
      minind2 = minind;
      minind = i;
    }
  }
  float ratio = mindist / (mindist + mindist2);
  float r = random(1.0) * 0.4 + 0.25;
  if (r > ratio)
    c.xyz = colors[minind];
  else 
    c.xyz = colors[minind2];

  c.xyz = mix(mix(colors[minind], colors[minind2], ratio), c.xyz, 0.5);
  
  if (invert_color)
    c = vec4(vec3(c.a, c.a, c.a) - vec3(c), c.a);
  c *= opacity;
  gl_FragColor = vec4(c);
}
