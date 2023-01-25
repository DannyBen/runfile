module Runfile
  module Inspectable
    def inspect
      return %[#<#{self.class}>] unless inspectable

      %[#<#{self.class} #{inspectable.map { |k, v| "#{k}=#{v.inspect}" }.join(', ')}>]
    end

    def inspectable
      nil
    end
  end
end
