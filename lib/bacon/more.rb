require 'bacon'

class Object
  
  def is(other)
    should.equal other
  end

  def isnt(other)
    should.not.equal other
  end

  def isa(other)
    self.class.should.equal other
  end

  def matches(other)
    other = Regexp.new(Regexp.escape(other)) if other.is_a?(String)
    should.match other
  end

  # element wise matching using each
  def enums(other)
    self_ar = []
    self.each do |v|
      self_ar << v
    end
    other_ar = []
    other.each do |v|
      other_ar << v
    end
    self_ar.zip(other_ar) do |a,b|
      a.should.equal b
    end
  end

  def ok
    should.equal true
  end
end

module Bacon
  class Context
    def ok(arg)
      arg.should.equal true
    end

    def hash_match(hash, obj)
      hash.each do |k,v|
        if v.is_a?(Hash)
          hash_match(v, obj.send(k.to_sym))
        else
          puts "#{k}: #{v} but was #{obj.send(k.to_sym)}" if obj.send(k.to_sym) != v
          obj.send(k.to_sym).should.equal v
        end
      end
    end
  end
end

def xit(*args, &block)
  puts "\nSKIPPING: #{args}"
end

def xdescribe(*args, &block)
  puts "\nSKIPPING: #{args}"
end

