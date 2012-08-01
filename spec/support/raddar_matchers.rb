RSpec::Matchers.define :be_a_raddar_model do
  match do |resource|
    resource.kind_of? Raddar::Model
  end
end

RSpec::Matchers.define :have_slug do |field|
  match do |resource|
    resource.kind_of?(Mongoid::Slug) and resource.slugged_attributes.include?(field.to_s)
  end
end

RSpec::Matchers.define :be_ordered_by do |params|
  match do |collection|
    value = params.first
    
    case params.last
    when :desc
      operator = :>
    when :asc
      operator = :<
    end
      
    pass = true

    collection.each_with_index do |element, i|
      if i > 0
        if element.send(value).send(operator, collection[i-1].send(value))
          pass = false
          break
        end 
      end
    end

    pass
  end
end



