function toanglesyx(vec3)
	local x = vec3.x
	local y = vec3.y
	local z = vec3.z
	return math.asin(y / (x * x + y * y + z * z) ^ 0.5), math.atan2(-x, -z)
end