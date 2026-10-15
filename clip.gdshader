shader_type canvas_item;

void fragment() {
    // Obtém a cor atual e o alpha original do pixel do Sprite
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Inverte o valor do alpha (1.0 vira 0.0, e 0.0 vira 1.0)
    float inverted_alpha = 1.0 - tex_color.a;
    
    // Aplica a cor original com o novo alpha invertido
    COLOR = vec4(tex_color.rgb, inverted_alpha);
}
