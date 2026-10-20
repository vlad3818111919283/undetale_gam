// Изменяем прозрачность в зависимости от состояния
fade_alpha += fade_speed * fade_state;

// ЕСЛИ ЭКРАН ПОЛНОСТЬЮ ПОЧЕРНЕЛ (Затухание закончилось)
if (fade_alpha >= 1 && fade_state == 1) {
    fade_alpha = 1;
    
    // Переносим игрока на новые координаты (если он существует)
    if (instance_exists(obj_player)) {
        obj_player.x = target_x;
        obj_player.y = target_y;
    }
    
    // Меняем комнату
    room_goto(target_room);
    
    // Меняем состояние: теперь экран должен начать светлеть
    fade_state = -1;
}

// ЕСЛИ ЭКРАН ПОЛНОСТЬЮ ОСВЕТЛИЛСЯ (Появление закончилось)
if (fade_alpha <= 0 && fade_state == -1) {
    // Эффект выполнен, объект больше не нужен — уничтожаем его
    instance_destroy();
}
