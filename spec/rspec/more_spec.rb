require 'spec_helper'

class MyClass 
  attr_accessor :color, :height
  def initialize(color, height)
    @color = color
    @height = height
  end
  
  def each(&block)
    [@color, @height].each(&block)
  end
end

describe "rspec/more" do
  before do
    @obj1 = MyClass.new('blue', 52)
    @obj2 = MyClass.new('blue', 52)
    @obj3 = MyClass.new('red', 532)
  end

  it "has syntax like Test::More" do
    @obj1.color.is 'blue' 
    @obj1.isa MyClass
    @obj1.color.isnt 'purple'
    ok  @obj1.color == @obj2.color 

    # and the negations
    prcs = [lambda { @obj1.color.is 'green' }, 
      lambda { @obj1.isa Hash },
      lambda { @obj1.color.isnt 'blue' },
      lambda { ok @obj1.color == @obj3.color }]
    prcs.each do |prc|
      prc.should.raise(Bacon::Error) 
    end
  end

  it 'can check enumerable objects' do
    @obj1.enums ['blue', 52]
    @obj1.enums @obj2  # obj2 is also enumerable
    lambda {@obj1.enums ['blue', 53]}.should.raise(Bacon::Error)
  end

  it 'can turn on and off specs and contexts' do
    xit 'just skip this check for now' do end.should.be.nil
    xdescribe 'just skip this context for now' do end.should.be.nil
  end

  it 'can match regular expressions or strings' do
    "doggy".matches /ogg/
    "do(gg)[^]y".matches 'o(gg)[^]'  # the string should match inside no matter what
    lambda {"do(gg)[^]y".matches 'oompa loompa'}.should.raise(Bacon::Error)
    lambda {"do(gg)[^]y".matches /o(gg)/}.should.raise(Bacon::Error)
  end
end
