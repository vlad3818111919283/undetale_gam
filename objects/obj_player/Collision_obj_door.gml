// Проверяем, не запущен ли переход прямо сейчас, чтобы не создавать дубликаты
if (!instance_exists(obj_fade)) {
    
    // Создаем объект затемнения
    var _inst = instance_create_depth(0, 0, 0, obj_fade);
    
    // Передаем в него все настройки из той конкретной двери, на которую наступил игрок
    _inst.target_room = other.target_room;
    _inst.target_x    = other.target_x;
    _inst.target_y    = other.target_y;
    
    // Запрещаем игроку двигаться во время анимации перехода (опционально, для канона)
    x_speed = 0;
    y_speed = 0;
}
