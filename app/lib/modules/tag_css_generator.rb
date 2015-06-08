class TagCssGenerator
  class << self
    def generate
      
      begin
        # Generate CSS Rules
        output = ""
        Tag.all.each do |tag|
          output << ".post-tag.post-#{tag.name} { border-color: #{tag.color}; color: #{tag.color}; } \n"
          output << ".post-tag.post-#{tag.name}:hover{ background-color:#{tag.color}; } \n"
        end

        # Output Css to File
        file_path = Rails.root.join('public','assets','tags.css')
        File.open(file_path, 'w') do |f|
          f.puts output
        end
        true
      rescue 
        false
      end
    end
  end
end
