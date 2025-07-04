#version 460 core
out vec4 FragColor;
  
in vec2 TexCoord;

uniform sampler2D TextureDiffuse1;

void main()
{
    FragColor = texture(TextureDiffuse1, TexCoord);
}