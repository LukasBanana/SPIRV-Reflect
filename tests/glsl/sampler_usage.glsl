#version 450
#pragma shader_stage(fragment)

// These should be listed as "accessed = true"
layout(binding = 0) uniform sampler linearSampler;
layout(binding = 1) uniform sampler nearestSampler;
layout(binding = 2) uniform texture2D separateTexA;
layout(binding = 3) uniform texture2D separateTexB;
layout(binding = 4) uniform sampler2D combinedTexSampler;

// These should be listed as "accessed = false'
layout(binding = 5) uniform sampler unusedSampler;
layout(binding = 6) uniform texture2D unusedSeparateTex;
layout(binding = 7) uniform sampler2D unusedCombinedTexSampler;

// Input/output variables
layout(location = 0) in vec2 texCoord;
layout(location = 0) out vec4 color;

// Sampler usage:
//   linearSampler { separateTexA, separateTexB }
//   nearestSampler { separateTexA }
void main() {
  vec4 c0 = texture(sampler2D(separateTexA, linearSampler), texCoord);
  vec4 c1 = texture(sampler2D(separateTexA, nearestSampler), texCoord);
  vec4 c2 = texture(sampler2D(separateTexB, linearSampler), texCoord);
  vec4 c3 = texture(sampler2D(separateTexA, linearSampler), texCoord * vec2(2)); // Second usage of same texture-sampler combination
  vec4 c4 = texture(combinedTexSampler, texCoord);
  color = c0 + c1 + c2 + c3;
}
