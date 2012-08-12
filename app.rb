require 'bundler'
Bundler.require

require 'open-uri'

require './ermahgerd'

get '*' do
  f = open "http://jessedodds.com#{params[:splat].first}"
  type = f.content_type
  body = f.read

  if type == 'text/html'
    doc = Nokogiri::HTML(body)
    doc.traverse do |node|
      if node.text?
        node.content = Ermahgerd.ternslert_terkst node.content
      elsif node.name == 'script'
        if node.has_attribute?('src') && node.get_attribute('src').match(/use\.typekit\.net/)
          node.set_attribute 'src', "//use.typekit.net/eed3xqc.js"
        end
        # jessedodds.com <script type="text/javascript" src="//use.typekit.net/nip2dbc.js"></script>
        # jerserderds.com <script type="text/javascript" src="//use.typekit.net/eed3xqc.js"></script>
      end
    end
    body = doc.to_html
  end

  [
    200,
    {
      "Content-Type" => type
    }, 
    body
  ]
end