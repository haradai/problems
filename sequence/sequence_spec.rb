require './sequence'

describe ProblemSequence do
  before :all do
    @file = File.open 'in.txt'
  end

  before do
    @p = ProblemSequence.new
  end

  context 'main' do
    it '' do
      @file.each_line do |line|
        input = line.split(",").map(&:strip)
        p input
        res = @p.main input[0]
        p res
        expect(res[0]).to eq input[1].to_i
      end
    end
  end
end
