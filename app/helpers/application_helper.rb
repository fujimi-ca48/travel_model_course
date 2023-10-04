module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'Travel Model Course'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def page_title(page_title = '', admin = false)
    base_title = if admin
                  '管理者画面 Travel Model Course'
                 else
                  'Travel Model Course'
                 end

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      title: 'Travel Model Course',
      reverse: true,
      description: 'あなたのおすすめの穴場スポットをモデルコースとして投稿しよう!',
      keywords: '旅行,観光,穴場スポット,モデルコース,リモートワーク,ランチ,ディナー,お出かけ',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: 'Travel Model Course',
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@Y_I7777',
        image: image_url('ogp.png')
      }
    }
  end
end
