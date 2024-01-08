// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// app/assets/javascripts/application.js

// app/assets/javascripts/application.js

// app/assets/javascripts/application.js

document.addEventListener('turbolinks:load', function() {
    // ボタンがクリックされたときの処理
    document.querySelector('.btn').addEventListener('click', function() {
        // ヘッダーのリンクのスタイルを変更
        document.querySelectorAll('header a').forEach(function(link) {
            link.classList.add('clicked-link'); // クラスを追加
        });
    });
});


