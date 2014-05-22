<?php
$data = file_get_contents('/home/daniel/.config/google-chrome-beta/Default/Bookmarks');
$json = json_decode($data);

$bookmarkbar = $json->roots->bookmark_bar->children;


function bookmarks($input)
{
    foreach($input as $bookmark)
    {
        if($bookmark->type == 'folder') {
            $bookmarks = array_merge(bookmarks($bookmark->children), $bookmarks);
        } else {
            if(!empty($bookmark->name) && !empty($bookmark->url))
                $bookmarks[] = ['name' => $bookmark->name, 'url' => $bookmark->url];
        }
    }

    return $bookmarks;
}
$bookmarks = bookmarks($bookmarkbar);
foreach($bookmarks as $bookmark) {
    echo $bookmark['name'] . ";s;" . $bookmark['url'] . "\n";
}

