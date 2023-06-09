import Foundation

struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    var subtitle: String
}

var intros: [Intro] = [
    .init(image: "Redesign", title: "Переработанный дизайн", subtitle: "Новый дизайн прост, удобен и красив! Изысканное белое и черное оформления будут идеально сочетаться с оформлением твоего устройства и днем и ночью"),
    .init(image: "Appearance", title: "Кастомизация", subtitle: "Подбирай любые цвета, что тебе по вкусу. Ставь как статичные, так и адаптивные цвета, чтобы уберечь свои глаза в темное время суток!"),
    .init(image: "Offline", title: "Оффлайн режим", subtitle: "Все предметы сохраняются в памяти устройства, поэтому ты сможешь смотреть расписание даже при полном отсутствии связи!"),
    .init(image: "Perfomance", title: "Возросшая производительность", subtitle: "Новое расписание работает до трех раз быстрее чем раньше! Новые технологии позволили в разы улучшить скорость работы расписания, так что теперь ты точно не заснешь при загрузке")
]
