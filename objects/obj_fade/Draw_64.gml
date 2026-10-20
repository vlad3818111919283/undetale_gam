// Если прозрачность больше нуля, рисуем черный экран
if (fade_alpha > 0) {
    // Устанавливаем черный цвет и текущую прозрачность
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    
    // Рисуем прямоугольник на весь экран интерфейса
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    // Сбрасываем настройки рисования обратно на стандартные, чтобы не испортить другие объекты
    draw_set_alpha(1);
    draw_set_color(c_white);
}
