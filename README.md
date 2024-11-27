```mermaid
mindmap
  root((Клиент-серверная система для издательства))
    Процессы
      Обработка запросов
        Получение запросов от автора
        Проверка данных
        Регистрация запроса
      Редактирование
        Литературное редактирование
        Корректура
        Подготовка к дизайну
      Дизайн
        Разработка макета
        Применение стиля
        Генерация превью
      Печать
        Подготовка печатного образца
        Производство тиража
        Контроль качества
    
    Технологии
      Языки программирования
        Python
        JavaScript
        Java
      Базы данных
        PostgreSQL
        MongoDB
      Протоколы
        HTTP/HTTPS
        WebSocket
      Фреймворки
        Spring
        Express.js
    
    Архитектура
      Одноуровневая
      Многоуровневая
        Frontend
        Backend
        База данных
    
    Задачи проектирования
      Масштабируемость
      Безопасность
        Шифрование
        Аутентификация
      Оптимизация
      Балансировка нагрузки


gitGraph
   commit id: "Начало проекта"
   branch feature-requests
   commit id: "Добавить обработку запросов"
   commit id: "Обработать запросы авторов"
   checkout main
   merge feature-requests id: "Слияние обработки запросов в main"
   
   branch feature-editing
   commit id: "Редактирование текста книги"
   commit id: "Сохранить изменения в базе данных"
   checkout main
   merge feature-editing id: "Слияние редактирования в main"
   
   branch feature-design
   commit id: "Создать дизайн и макет"
   commit id: "Генерация превью"
   checkout main
   merge feature-design id: "Слияние дизайна в main"
   
   branch feature-printing
   commit id: "Подготовка книги к печати"
   commit id: "Сохранение данных о печати"
   checkout main
   merge feature-printing id: "Слияние печати в main"
   
   commit id: "Финализация системы"
