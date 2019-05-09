shader_type canvas_item;

uniform float color_bleeding = 0.5;
uniform float bleeding_range = 1;
uniform float screen_width = 320;
uniform float brightness = 0.5;
//scan lines
uniform float lines_distance = 4.0;
uniform float scan_pixel_size = 1.0;
uniform float size_screen = 600;
uniform float scanline_alpha = 0.98;
uniform float lines_velocity = 60;
void fragment()
{
	float pixel_size = 1.0/screen_width*bleeding_range;
	vec4 color_left = texture(SCREEN_TEXTURE,SCREEN_UV - vec2(pixel_size, 0));
	vec4 current_color = texture(SCREEN_TEXTURE,SCREEN_UV);
	//current_color = current_color*vec4(color_bleeding,0.5,0.25,1);
	//color_left = color_left*vec4(0.25,0.5,color_bleeding,1);
	current_color = current_color*vec4(color_bleeding,brightness,brightness,1);
	color_left = color_left*vec4(brightness,brightness,color_bleeding,1);
	COLOR.rgba = (current_color + color_left);
//scanline
	float line_row = floor((SCREEN_UV.y * size_screen/scan_pixel_size) + mod(TIME*lines_velocity, lines_distance));

	float n = 1.0 - ceil((mod(line_row,lines_distance)/lines_distance));

vec4 c = texture(SCREEN_TEXTURE,SCREEN_UV);
c = c - n*c*(1.0 - scanline_alpha);
c.a = 1.0;
//COLOR = c;
}