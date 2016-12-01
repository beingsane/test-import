<?php

main();

function main()
{
    $data = file_get_contents('data.json');
    $data = json_decode($data, true);


    $host = 'localhost';
    $dbname = 'test';
    $user = 'root';
    $password = '';

    $dsn = "mysql:host=$host;dbname=$dbname;charset=UTF8";
    $opt = array(
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    );
    $pdo = new PDO($dsn, $user, $password, $opt);


    $statement = $pdo->prepare('DELETE FROM news');
    $statement->execute();

    $statement = $pdo->prepare('DELETE FROM category');
    $statement->execute();


    importCategories($pdo, $data, null);
}


function importCategories($pdo, $data, $parentCategoryId)
{
    foreach ($data as $categoryData) {
        importCategoryItem($pdo, $categoryData, $parentCategoryId);
    }
}

function importCategoryItem($pdo, $categoryData, $parentCategoryId)
{
    if (!is_array($categoryData)) {
        // skip invalid data
        return;
    }

    $categoryDbData = [
        ':id' => $categoryData['id'],
        ':parent_id' => $parentCategoryId,
        ':name' => $categoryData['name'],
        ':active' => (int)$categoryData['active'],
    ];
    logData($categoryDbData);

    $statement = $pdo->prepare('
        INSERT INTO category (id, parent_id, name, active)
        VALUES (:id, :parent_id, :name, :active)
    ');
    $res = $statement->execute($categoryDbData);

    if ($res) {
        $categoryId = $categoryData['id'];

        if (isset($categoryData['subcategories'])) {
            importCategories($pdo, $categoryData['subcategories'], $categoryId);
        }

        if (isset($categoryData['news'])) {
            importNews($pdo, $categoryData['news'], $categoryId);
        }
    }
}

function importNews($pdo, $data, $categoryId)
{
    foreach ($data as $newsData) {
        importNewsItem($pdo, $newsData, $categoryId);
    }
}

function importNewsItem($pdo, $newsData, $categoryId)
{
    if (!is_array($newsData)) {
        // skip invalid data
        return;
    }

    $newsDbData = [
        ':id' => $newsData['id'],
        ':category_id' => $categoryId,
        ':active' => (int)$newsData['active'],
        ':title' => $newsData['title'],
        ':image' => $newsData['image'],
        ':description' => $newsData['description'],
        ':text' => $newsData['text'],
        ':date' => $newsData['date'],
    ];
    logData($newsDbData);

    $statement = $pdo->prepare('
        INSERT INTO news (id, category_id, active, title, image, description, text, date)
        VALUES (:id, :category_id, :active, :title, :image, :description, :text, :date)
    ');
    $statement->execute($newsDbData);
}

function logData($data)
{
    var_dump($data);
}
