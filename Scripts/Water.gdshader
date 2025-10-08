shader_type canvas_item;

uniform float wave_speed = 0.25;
uniform float wave_amplitude = 1.5;
uniform float wave_frequency = 1.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float distortion_amount = 0.01;
uniform vec4 water_color : source_color = vec4(0.0, 0.15, 0.25, 0.85);
uniform float water_tint_strength = 0.4;
uniform float depth_darkening = 1.5;
uniform float underwater_depth = 0.0;

void fragment() {
    vec2 uv = UV;
    float time = TIME;

    // Dalga kuvveti sadece yüzeye yakın yerlerde etkili olsun
    float wave_strength = pow(uv.y, 2.0); // dipte 0, yüzeye yakın 1
    float wave = sin(uv.x * wave_frequency + time * wave_speed) * wave_amplitude * wave_strength;

    // Dalgayla ekran kırılması
    vec2 distorted_uv = SCREEN_UV + vec2(0.0, wave * distortion_amount);
    vec4 screen_color = texture(SCREEN_TEXTURE, distorted_uv);

    // Derinliğe bağlı kararma ve renklendirme
    float depth = uv.y;
    float depth_fade = clamp(depth * depth_darkening + underwater_depth, 0.0, 1.0);
    vec4 tinted = mix(screen_color, water_color, depth_fade * water_tint_strength);

    COLOR = tinted;
}
