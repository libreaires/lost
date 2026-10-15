shader_type canvas_item;
render_mode unshaded;

// ATTRIBUTES
uniform float circleSize : hint_range(0.0, 1.0) = 0.2;
uniform vec2 screenResolution = vec2(1024.0, 600.0);
uniform vec2 circlePosition = vec2(512.0, 300.0);
// END


// SHADER
void fragment() {
    vec2 normalizedPlacement = circlePosition / screenResolution;
    float ratio = screenResolution.x / screenResolution.y;
    vec2 uv = UV; uv.x *= ratio; vec2 center = normalizedPlacement; center.x *= ratio;
    float distanced = distance(center, uv);
    COLOR.a = step(circleSize, distanced); // CHANGED: Removed 1.0 - to restore the original hole-punch/inverted alpha behavior
}
// END