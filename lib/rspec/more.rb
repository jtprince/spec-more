require 'rspec'

class Object
  
  def is(other)
    should == other
  end

  def isnt(other)
    should_not == other
  end

  def isa(klass)
    self.should be_a_kind_of(klass)
  end

  def matches(other)
    other = Regexp.new(Regexp.escape(other)) if other.is_a?(String)
    self.should match(other)
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
      a.should == b
    end
  end

  def ok
    self.should be_true
  end
end

module RSpec::Core::DSL

  def ok(arg)
    arg.should.equal true
  end

  def xdescribe(*args, &block)
    puts "\nSKIPPING: #{args}"
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
include RSpec::Core::DSL

