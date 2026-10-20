// 1. Получаем ввод с клавиатуры (стрелочки или WASD)
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _key_up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _key_down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

// 2. Расчет направления движения
// Вычитание дает нам: 1 (вправо/вниз), -1 (влево/вверх) или 0 (стоим)
var _hor_dir = _key_right - _key_left;
var _ver_dir = _key_down - _key_up;

// 3. Расчет скорости с защитой от быстрого бега по диагонали
if (_hor_dir != 0 || _ver_dir != 0) {
    // Находим угол движения (в радианах)
    var _move_dir = point_direction(0, 0, _hor_dir, _ver_dir);
    
    // Раскладываем скорость на X и Y компоненты при помощи тригонометрии
    x_speed = lengthdir_x(move_speed, _move_dir);
    y_speed = lengthdir_y(move_speed, _move_dir);
} else {
    x_speed = 0;
    y_speed = 0;
}

// 4. Проверка коллизий (столкновений со стеной obj_wall) по горизонтали
if (place_meeting(x + x_speed, y, obj_wall)) {
    // Попиксельно подходим к стене вплотную
    while (!place_meeting(x + sign(x_speed), y, obj_wall)) {
        x += sign(x_speed);
    }
    x_speed = 0; // Останавливаемся
}
x += x_speed; // Применяем движение по X

// Проверка коллизий по вертикали
if (place_meeting(x, y + y_speed, obj_wall)) {
    // Попиксельно подходим к стене вплотную
    while (!place_meeting(x, y + sign(y_speed), obj_wall)) {
        y += sign(y_speed);
    }
    y_speed = 0; // Останавливаемся
}
y += y_speed; // Применяем движение по Y

// 5. Логика анимаций
if (_hor_dir != 0 || _ver_dir != 0) {
    // Включаем проигрывание анимации
    image_speed = 1; 
    
    // Определяем, куда смотрит персонаж, и ставим соответствующий беговой спрайт
    if (_hor_dir > 0) { sprite_index = spr_player_right; face_direction = "right"; }
    else if (_hor_dir < 0) { sprite_index = spr_player_left; face_direction = "left"; }
    else if (_ver_dir > 0) { sprite_index = spr_player_down; face_direction = "down"; }
    else if (_ver_dir < 0) { sprite_index = spr_player_up; face_direction = "up"; }
} else {
    // Если стоим на месте — останавливаем анимацию на 0-м (стартовом) кадре шага
    image_speed = 0;
    image_index = 0;
    
    // Возвращаем спрайт покоя в зависимости от того, куда смотрели последний раз
    if (face_direction == "right") sprite_index = spr_player_idle_right;
    if (face_direction == "left")  sprite_index = spr_player_idle_left;
    if (face_direction == "up")    sprite_index = spr_player_idle_up;
    if (face_direction == "down")  sprite_index = spr_player_idle_down;
}
