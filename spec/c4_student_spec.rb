require 'spec_helper'

describe 'C4 standard board size' do
    it 'detects P1 winning horizontally in row 0' do
        # Notice that the game should end before the last 'q' input is consumed
        result = test_c4('aabbccdq')
        expect(result).to declare_win_for 1
    end

    it 'quits before declaring a winner in column 0' do
        result = test_c4('abababq')
        expect(result).to be_abandoned
    end
end


describe 'Connect 4 alternate' do
    it 'detects player 2 winning horizontally on a big board' do
        result = test_c4('iaabbccddeeffgq', 3, 9, 7)
        expect(result).to declare_win_for 2
    end

    it 'quits before declaring a winner in column 0' do
        result = test_c4('iaabbccddeeffq', 3, 9, 7)
        expect(result).to be_abandoned
    end
end