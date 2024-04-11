module App
  module Data
    module_function
    
    def sprays_data(doc)
      data       = {}
      categories = doc.xpath('@data-title')
      titles     = doc.xpath('@data-color-title')
      rgbs       = doc.xpath('@data-rgb')
      hexs       = doc.xpath('@data-hex')
      eans       = doc.xpath('@data-ean')
    
      titles.length.times do |i|
        category = categories[i].text.to_sym
        title    = titles[i].text.scan(/(.*[0-9]+)\s(.*)/)[0]
        rgb      = JSON.parse(rgbs[i].text)
        hex      = hexs[i].text
        ean      = eans[i].text
    
        unless rgb['R'].empty?
          unless data.key?(category)
            data[category] = []
          end
          
          data[category] << {
            title[0].to_sym => {
              name: title[1],
              rgb: {
                r: rgb['R'],
                g: rgb['G'],
                b: rgb['B']
              },
              hex: hex,
              ean: ean,
            }    
          }
        end
      end
      
      data
    end
  end#Data
end