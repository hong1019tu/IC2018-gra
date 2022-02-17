module huffman(clk, reset, gray_valid, CNT_valid, CNT1, CNT2, CNT3, CNT4, CNT5, CNT6,
    code_valid, HC1, HC2, HC3, HC4, HC5, HC6,M1, M2, M3, M4, M5, M6,gray_data);

input clk;
input reset;
input gray_valid;
input [7:0] gray_data;
output reg CNT_valid;
output reg [7:0] CNT1, CNT2, CNT3, CNT4, CNT5, CNT6;
output reg code_valid;
output reg [7:0] HC1, HC2, HC3, HC4, HC5, HC6;
output reg [7:0] M1, M2, M3, M4, M5, M6;
reg [8:0] cur,count;
reg [7:0] arr[5:0];
reg [5:0] cnt,sort_cnt;
reg [5:0]symbol[5:0][7:0];
reg [1:0]code[5:0][7:0];
integer i,j,k;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt <= 6'd1;
        sort_cnt <= 0;
        CNT_valid <= 1'd0;
        code_valid <= 1'd0;
        cur <= 1'd0;
        count <= 0;
        CNT1 <= 8'd0;
        CNT2 <= 8'd0;
        CNT3 <= 8'd0;
        CNT4 <= 8'd0;
        CNT5 <= 8'd0;
        CNT6 <= 8'd0;
        for (k = 0;k < 8 ;k=k+1 ) begin
            for(j = 0;j < 6;j = j+1)begin
                if(k == 0)begin
                    symbol[j][k] <= j+1;
                end
                else begin        
                    symbol[j][k] <= 6'd0;
                end
                code[j][k] <= 2'd3;
            end
        end
    end
    else begin
        case (cur)
            0:begin//count number
            count <= count + 1;
                if (gray_valid == 1) begin
                    count <= count + 1;
                    case (gray_data)
                        8'd1:begin
                            CNT1 <= CNT1 + 1;
                        end
                        8'd2:begin
                            CNT2 <= CNT2 + 1;
                        end
                        8'd3:begin
                            CNT3 <= CNT3 + 1;
                        end
                        8'd4:begin
                            CNT4 <= CNT4 + 1;
                        end
                        8'd5:begin
                            CNT5 <= CNT5 + 1;
                        end
                        8'd6:begin
                            CNT6 <= CNT6 + 1;
                        end
                    endcase
                end
                else if(count == 103)begin
                    arr[0] <= CNT1;
                    arr[1] <= CNT2;
                    arr[2] <= CNT3;
                    arr[3] <= CNT4;
                    arr[4] <= CNT5;
                    arr[5] <= CNT6;
                end
                else if(count == 104)begin//find max
                    for(i=0;i<6;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(count == 105)begin//find max
                    for(i=1;i<5;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(count == 106)begin//find max
                    for(i=0;i<6;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(count == 107)begin//find max
                    for(i=1;i<5;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(count == 108)begin//find max
                    for(i=0;i<6;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(count == 109)begin//find max
                    for(i=1;i<5;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1] || ((arr[i] == arr[i+1])&&(symbol[i][0] < symbol[i+1][0]))) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                    cur <= 1;
                    CNT_valid <= 1'd1;
                end
            end
            1:begin//merge//start
                if(cnt == 5)begin
                    cur <= 3;
                    cnt <= 0;
                end
                else begin
                    cur <= 2;
                    sort_cnt <= 0;
                end
                arr[cnt] <= arr[cnt - 1] + arr[cnt];
                arr[cnt-1] <= 8'd0;
                for(j = 0;(j < 7)&&(symbol[cnt][j] != 0);j=j+1)begin//???
                    if(code[symbol[cnt][j]-1][0]==3)begin
                        code[symbol[cnt][j]-1][0] <= 2'd0;    
                    end
                    else if(code[symbol[cnt][j]-1][1]==3)begin
                        code[symbol[cnt][j]-1][1] <= 2'd0;    
                    end
                    else if(code[symbol[cnt][j]-1][2]==3)begin
                        code[symbol[cnt][j]-1][2] <= 2'd0;    
                    end
                    else if(code[symbol[cnt][j]-1][3]==3)begin
                        code[symbol[cnt][j]-1][3] <= 2'd0;    
                    end
                    else if(code[symbol[cnt][j]-1][4]==3)begin
                        code[symbol[cnt][j]-1][4] <= 2'd0;    
                    end
                    else if(code[symbol[cnt][j]-1][5]==3)begin
                        code[symbol[cnt][j]-1][5] <= 2'd0;    
                    end
                    else if(code[symbol[cnt][j]-1][6]==3)begin
                        code[symbol[cnt][j]-1][6] <= 2'd0;    
                    end
                    else if(code[symbol[cnt][j]-1][7]==3)begin
                        code[symbol[cnt][j]-1][7] <= 2'd0;    
                    end
                end
                if(j <= 6 && symbol[cnt-1][0]!=0)begin
                    symbol[cnt][j] <= symbol[cnt-1][0];
                    symbol[cnt-1][0] <= 6'd0;
                    if(code[symbol[cnt-1][0]-1][0]==3)begin//cnt->cnt-1
                        code[symbol[cnt-1][0]-1][0] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][0]-1][1]==3)begin
                        code[symbol[cnt-1][0]-1][1] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][0]-1][2]==3)begin
                        code[symbol[cnt-1][0]-1][2] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][0]-1][3]==3)begin
                        code[symbol[cnt-1][0]-1][3] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][0]-1][4]==3)begin
                        code[symbol[cnt-1][0]-1][4] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][0]-1][5]==3)begin
                        code[symbol[cnt-1][0]-1][5] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][0]-1][6]==3)begin
                        code[symbol[cnt-1][0]-1][6] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][0]-1][7]==3)begin
                        code[symbol[cnt-1][0]-1][7] <= 2'd1;    
                    end
                end
                if(j+1 <= 6 && symbol[cnt-1][1]!=0)begin
                    symbol[cnt][j+1] <= symbol[cnt-1][1];
                    symbol[cnt-1][1] <= 6'd0;
                    if(code[symbol[cnt-1][1]-1][1]==3)begin
                        code[symbol[cnt-1][1]-1][1] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][1]-1][2]==3)begin
                        code[symbol[cnt-1][1]-1][2] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][1]-1][3]==3)begin
                        code[symbol[cnt-1][1]-1][3] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][1]-1][4]==3)begin
                        code[symbol[cnt-1][1]-1][4] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][1]-1][5]==3)begin
                        code[symbol[cnt-1][1]-1][5] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][1]-1][6]==3)begin
                        code[symbol[cnt-1][1]-1][6] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][1]-1][7]==3)begin
                        code[symbol[cnt-1][1]-1][7] <= 2'd1;    
                    end
                end

                if(j+2 <= 6 && symbol[cnt-1][2]!=0)begin
                    symbol[cnt][j+2] <= symbol[cnt-1][2];
                    symbol[cnt-1][2] <= 6'd0;
                    if(code[symbol[cnt-1][2]-1][2]==3)begin
                        code[symbol[cnt-1][2]-1][2] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][2]-1][3]==3)begin
                        code[symbol[cnt-1][2]-1][3] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][2]-1][4]==3)begin
                        code[symbol[cnt-1][2]-1][4] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][2]-1][5]==3)begin
                        code[symbol[cnt-1][2]-1][5] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][2]-1][6]==3)begin
                        code[symbol[cnt-1][2]-1][6] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][2]-1][7]==3)begin
                        code[symbol[cnt-1][2]-1][7] <= 2'd1;    
                    end
                end
                if(j+3 <= 6 && symbol[cnt-1][3]!=0)begin
                    symbol[cnt][j+3] <= symbol[cnt-1][3];
                    symbol[cnt-1][3] <= 6'd0;

                    if(code[symbol[cnt-1][3]-1][1]==3)begin
                        code[symbol[cnt-1][3]-1][1] <= 2'd1;    
                    end

                    else if(code[symbol[cnt-1][3]-1][3]==3)begin
                        code[symbol[cnt-1][3]-1][3] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][3]-1][4]==3)begin
                        code[symbol[cnt-1][3]-1][4] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][3]-1][5]==3)begin
                        code[symbol[cnt-1][3]-1][5] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][3]-1][6]==3)begin
                        code[symbol[cnt-1][3]-1][6] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][3]-1][7]==3)begin
                        code[symbol[cnt-1][3]-1][7] <= 2'd1;    
                    end
                end
                if(j+4 <= 6 && symbol[cnt-1][4]!=0)begin
                    symbol[cnt][j+4] <= symbol[cnt-1][4];
                    symbol[cnt-1][4] <= 6'd0;
                    if(code[symbol[cnt-1][4]-1][4]==3)begin
                        code[symbol[cnt-1][4]-1][4] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][4]-1][5]==3)begin
                        code[symbol[cnt-1][4]-1][5] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][4]-1][6]==3)begin
                        code[symbol[cnt-1][4]-1][6] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][4]-1][7]==3)begin
                        code[symbol[cnt-1][4]-1][7] <= 2'd1;    
                    end
                end
                if(j+5 <= 6 && symbol[cnt-1][5]!=0)begin
                    symbol[cnt][j+5] <= symbol[cnt-1][5];
                    symbol[cnt-1][5] <= 6'd0;
                    if(code[symbol[cnt-1][5]-1][5]==3)begin
                        code[symbol[cnt-1][5]-1][5] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][5]-1][6]==3)begin
                        code[symbol[cnt-1][5]-1][6] <= 2'd1;    
                    end
                    else if(code[symbol[cnt-1][5]-1][7]==3)begin
                        code[symbol[cnt-1][5]-1][7] <= 2'd1;    
                    end
                end 
            end
            2:begin//sort
                sort_cnt <= sort_cnt + 1;
                if(sort_cnt == 0)begin//find max
                    for(i=0;i<6;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1]) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1]) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1]) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1]) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(sort_cnt == 1)begin//find max
                    for(i=1;i<5;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1]) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1]) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1]) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1]) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(sort_cnt == 2)begin//find max
                    for(i=0;i<6;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1]) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1]) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1]) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1]) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(sort_cnt == 3)begin//find max
                    for(i=1;i<5;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1]) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1]) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1]) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1]) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(sort_cnt == 4)begin//find max
                    for(i=0;i<6;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1]) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1]) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1]) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1]) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                end
                else if(sort_cnt == 5)begin//find max
                    for(i=1;i<5;i=i+2)begin
                        arr[i] <= (arr[i] > arr[i+1]) ? arr[i+1] : arr[i];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i][k] <= (arr[i] > arr[i+1]) ? symbol[i+1][k] : symbol[i][k];
                        end
                        arr[i+1] <= (arr[i] > arr[i+1]) ? arr[i] : arr[i+1];
                        for(k=0;k<8;k=k+1)begin
                            symbol[i+1][k] <= (arr[i] > arr[i+1]) ? symbol[i][k] : symbol[i+1][k];
                        end
                    end
                    cur <= 1;
                    cnt <= cnt + 1;
                end
            end 
            3:begin//output ans
                M1[0] <= (code[0][0] == 3)?0:1;
                M1[1] <= (code[0][1] == 3)?0:1;
                M1[2] <= (code[0][2] == 3)?0:1;
                M1[3] <= (code[0][3] == 3)?0:1;
                M1[4] <= (code[0][4] == 3)?0:1;
                M1[5] <= (code[0][5] == 3)?0:1;
                M1[6] <= (code[0][6] == 3)?0:1;
                M1[7] <= (code[0][7] == 3)?0:1;
                HC1[0] <= (code[0][0] == 3)?0:(code[0][0] == 0)?0:1;
                HC1[1] <= (code[0][1] == 3)?0:(code[0][1] == 0)?0:1;
                HC1[2] <= (code[0][2] == 3)?0:(code[0][2] == 0)?0:1;
                HC1[3] <= (code[0][3] == 3)?0:(code[0][3] == 0)?0:1;
                HC1[4] <= (code[0][4] == 3)?0:(code[0][4] == 0)?0:1;
                HC1[5] <= (code[0][5] == 3)?0:(code[0][5] == 0)?0:1;
                HC1[6] <= (code[0][6] == 3)?0:(code[0][6] == 0)?0:1;
                HC1[7] <= (code[0][7] == 3)?0:(code[0][7] == 0)?0:1;
                M2[0] <= (code[1][0] == 3)?0:1;
                M2[1] <= (code[1][1] == 3)?0:1;
                M2[2] <= (code[1][2] == 3)?0:1;
                M2[3] <= (code[1][3] == 3)?0:1;
                M2[4] <= (code[1][4] == 3)?0:1;
                M2[5] <= (code[1][5] == 3)?0:1;
                M2[6] <= (code[1][6] == 3)?0:1;
                M2[7] <= (code[1][7] == 3)?0:1;
                HC2[0] <= (code[1][0] == 3)?0:(code[1][0] == 0)?0:1;
                HC2[1] <= (code[1][1] == 3)?0:(code[1][1] == 0)?0:1;
                HC2[2] <= (code[1][2] == 3)?0:(code[1][2] == 0)?0:1;
                HC2[3] <= (code[1][3] == 3)?0:(code[1][3] == 0)?0:1;
                HC2[4] <= (code[1][4] == 3)?0:(code[1][4] == 0)?0:1;
                HC2[5] <= (code[1][5] == 3)?0:(code[1][5] == 0)?0:1;
                HC2[6] <= (code[1][6] == 3)?0:(code[1][6] == 0)?0:1;
                HC2[7] <= (code[1][7] == 3)?0:(code[1][7] == 0)?0:1;
                M3[0] <= (code[2][0] == 3)?0:1;
                M3[1] <= (code[2][1] == 3)?0:1;
                M3[2] <= (code[2][2] == 3)?0:1;
                M3[3] <= (code[2][3] == 3)?0:1;
                M3[4] <= (code[2][4] == 3)?0:1;
                M3[5] <= (code[2][5] == 3)?0:1;
                M3[6] <= (code[2][6] == 3)?0:1;
                M3[7] <= (code[2][7] == 3)?0:1;
                HC3[0] <= (code[2][0] == 3)?0:(code[2][0] == 0)?0:1;
                HC3[1] <= (code[2][1] == 3)?0:(code[2][1] == 0)?0:1;
                HC3[2] <= (code[2][2] == 3)?0:(code[2][2] == 0)?0:1;
                HC3[3] <= (code[2][3] == 3)?0:(code[2][3] == 0)?0:1;
                HC3[4] <= (code[2][4] == 3)?0:(code[2][4] == 0)?0:1;
                HC3[5] <= (code[2][5] == 3)?0:(code[2][5] == 0)?0:1;
                HC3[6] <= (code[2][6] == 3)?0:(code[2][6] == 0)?0:1;
                HC3[7] <= (code[2][7] == 3)?0:(code[2][7] == 0)?0:1;
                M4[0] <= (code[3][0] == 3)?0:1;
                M4[1] <= (code[3][1] == 3)?0:1;
                M4[2] <= (code[3][2] == 3)?0:1;
                M4[3] <= (code[3][3] == 3)?0:1;
                M4[4] <= (code[3][4] == 3)?0:1;
                M4[5] <= (code[3][5] == 3)?0:1;
                M4[6] <= (code[3][6] == 3)?0:1;
                M4[7] <= (code[3][7] == 3)?0:1;
                HC4[0] <= (code[3][0] == 3)?0:(code[3][0] == 0)?0:1;
                HC4[1] <= (code[3][1] == 3)?0:(code[3][1] == 0)?0:1;
                HC4[2] <= (code[3][2] == 3)?0:(code[3][2] == 0)?0:1;
                HC4[3] <= (code[3][3] == 3)?0:(code[3][3] == 0)?0:1;
                HC4[4] <= (code[3][4] == 3)?0:(code[3][4] == 0)?0:1;
                HC4[5] <= (code[3][5] == 3)?0:(code[3][5] == 0)?0:1;
                HC4[6] <= (code[3][6] == 3)?0:(code[3][6] == 0)?0:1;
                HC4[7] <= (code[3][7] == 3)?0:(code[3][7] == 0)?0:1;
                M5[0] <= (code[4][0] == 3)?0:1;
                M5[1] <= (code[4][1] == 3)?0:1;
                M5[2] <= (code[4][2] == 3)?0:1;
                M5[3] <= (code[4][3] == 3)?0:1;
                M5[4] <= (code[4][4] == 3)?0:1;
                M5[5] <= (code[4][5] == 3)?0:1;
                M5[6] <= (code[4][6] == 3)?0:1;
                M5[7] <= (code[4][7] == 3)?0:1;
                HC5[0] <= (code[4][0] == 3)?0:(code[4][0] == 0)?0:1;
                HC5[1] <= (code[4][1] == 3)?0:(code[4][1] == 0)?0:1;
                HC5[2] <= (code[4][2] == 3)?0:(code[4][2] == 0)?0:1;
                HC5[3] <= (code[4][3] == 3)?0:(code[4][3] == 0)?0:1;
                HC5[4] <= (code[4][4] == 3)?0:(code[4][4] == 0)?0:1;
                HC5[5] <= (code[4][5] == 3)?0:(code[4][5] == 0)?0:1;
                HC5[6] <= (code[4][6] == 3)?0:(code[4][6] == 0)?0:1;
                HC5[7] <= (code[4][7] == 3)?0:(code[4][7] == 0)?0:1;
                M6[0] <= (code[5][0] == 3)?0:1;
                M6[1] <= (code[5][1] == 3)?0:1;
                M6[2] <= (code[5][2] == 3)?0:1;
                M6[3] <= (code[5][3] == 3)?0:1;
                M6[4] <= (code[5][4] == 3)?0:1;
                M6[5] <= (code[5][5] == 3)?0:1;
                M6[6] <= (code[5][6] == 3)?0:1;
                M6[7] <= (code[5][7] == 3)?0:1;
                HC6[0] <= (code[5][0] == 3)?0:(code[5][0] == 0)?0:1;
                HC6[1] <= (code[5][1] == 3)?0:(code[5][1] == 0)?0:1;
                HC6[2] <= (code[5][2] == 3)?0:(code[5][2] == 0)?0:1;
                HC6[3] <= (code[5][3] == 3)?0:(code[5][3] == 0)?0:1;
                HC6[4] <= (code[5][4] == 3)?0:(code[5][4] == 0)?0:1;
                HC6[5] <= (code[5][5] == 3)?0:(code[5][5] == 0)?0:1;
                HC6[6] <= (code[5][6] == 3)?0:(code[5][6] == 0)?0:1;
                HC6[7] <= (code[5][7] == 3)?0:(code[5][7] == 0)?0:1;
                code_valid <= 1'd1;  
            end           
        endcase
    end
end  
endmodule

