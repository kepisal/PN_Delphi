unit MyTable;

interface
uses
  SysUtils,
  Contnrs,
  math;
type
  TMyMessage = class
   private
    number  : Integer; //1
    date    : string;  //2
    name    : string;  //3
    version : string;  //4
    code    : string;  //5
    published
      function  getNumber():Integer;
      procedure setNumber(number:Integer);
      function  getDate():string;
      procedure setDate(date:String);
      function  getName():String;
      procedure setName(name:String);
      function  getVersion():String;
      procedure setVersion(version:String);
      function  getCode():String;
      procedure setCode(code:String);
  end;
  TMessageList = class(TObjectList)
  protected
    procedure setMessage(I : Integer; Msg: TMyMessage);
    function getMessage(I : Integer) : TMyMessage;
  public
    property Messages[I : Integer]:TMyMessage read getMessage write setMessage;
  end;
  TMessageTable = class
    private
      List : TMessageList;
    published
      constructor Create(list:TMessageList);
      function drawTable():String;
  end;

implementation
procedure TMyMessage.setNumber(number:Integer);
begin
  Self.number := number;
end;

function TMyMessage.getNumber;
begin
  Result := number;
end;

procedure TMyMessage.setDate(date:String);
begin
  Self.date := date;
end;

function TMyMessage.getDate;
begin
  Result := date;
end;

procedure TMyMessage.setName(name:String);
begin
  Self.name := name;
end;

function TMyMessage.getName;
begin
  Result := name;
end;

procedure TMyMessage.setVersion(version:String);
begin
  Self.version := version;
end;

function TMyMessage.getVersion;
begin
  Result := version;
end;
procedure TMyMessage.setCode(code:string);
begin
  Self.code := code;
end;
function TMyMessage.getCode;
begin
  Result := code;
end;
procedure TMessageList.setMessage(I : Integer; msg:TMyMessage);
begin
  Items[I] := Msg;
end;

function TMessageList.getMessage(I : Integer): TMyMessage;
begin
  Result := TMyMessage(Items[I]);
end;

constructor TMessageTable.Create(list:TMessageList);
begin
    Self.List := list;
end;
function TMessageTable.drawTable;
var
  i,j,k,m,temp,count,col,col1,col2,col3,col4,col5:Integer;
  head,head1,head2,head3,head4,head5:String;
  topLconer,topRconer,buttomLconer,buttomRconer,lineH,LineV,midTop,midButtom:Integer;
  header:String;
  space,Rspace,Lspace:Integer;
begin
  count := List.Count - 1;
  col1 := 0;
  col2 := 0;
  col3 := 0;
  col4 := 0;
  col5 := 0;
  head1 := '*';
  head2 := 'Date';
  head3 := 'Name';
  head4 := 'Version';
  head5 := 'code';
  topLconer := 201;
  topRconer := 187;
  buttomLconer := 200;
  buttomRconer := 188;
  lineH := 205;
  LineV := 186;
  midTop := 203;
  // find max string column
  for i := 0 to count do
  begin
    temp := Length(IntToStr(List.Messages[i].getNumber));
    if(col1 < temp)then
    col1 := temp;
    temp := Length(List.Messages[i].getDate);
    if(col2 < temp) then
    col2 := temp;
    temp := Length(List.Messages[i].getName);
    if(col3 < temp) then
    col3 := temp;
    temp := Length(List.Messages[i].getVersion);
    if(col4 < temp) then
    col4 := temp;
    temp := Length(List.Messages[i].getCode);
    if(col5 < temp) then
    col5 := temp;
    temp := 0;
  end;

  // Draw top header
  header := chr(topLconer);
  temp := Length(head1);
  if(temp <= col1) then
  begin
    for j:= 0 to col1 - 1 do
    begin
    header := header + chr(lineH);
    end;
  end;
  header := header + chr(midTop);
  temp := Length(head2);
  if(temp <= col2) then
  begin
    for j := 0 to col2 - 1 do
    begin
      header := header + chr(lineH);
    end;
  end;
  header := header + chr(midTop);
  temp := Length(head3);
  if(temp <= col3) then
  begin
    for j := 0 to col3 - 1 do
    begin
      header := header + chr(lineH);
    end;
  end;
  header := header + chr(midTop);
  temp := Length(head4);
  if(temp <= col4) then
  begin
    for j := 0 to col4 - 1 do
    begin
      header := header + chr(lineH);
    end;
  end;
  header := header + chr(midTop);
  temp := Length(head5);
  if(temp <= col5) then
  begin
    for j := 0 to col5  - 1do
    begin
      header := header + chr(lineH);
    end;
  end;
  header := header + chr(topRconer) + #13#10 + chr(lineV);

  //draw header name
  for i := 1 to 5 do
  begin
    if i = 1 then
      begin
      head := head1;
      col := col1;
      end

    else if i = 2 then
      begin
        head := head2;
      col := col2;
      end
    else if i = 3 then
      begin
        head := head3;
      col  := col3;
      end
    else if i = 4 then
      begin
        head := head4;
        col := col4;
      end
    else
      begin
        head := head5;
        col := col5
      end;

  if(Length(head) <= col) then
  begin
    space := col - Length(head);
    Rspace := Floor(space / 2);
    Lspace := Rspace;

    for j := 0 to Rspace - 1 do
    header := header + ' ';
    header := header + head;
    if (space mod 2) = 0 then
      begin
      for j := 0 to LSpace - 1 do
      header := header + ' ';
      end
    else
      begin
      for j := 0 to LSpace do
      header := header + ' ';
      end;
  end;
   header := header + chr(LineV);
  end;
  header := header + #13#10 + chr(204);


  // draw top buttom
  for i := 0 to col1 - 1 do
  begin
    header := header + chr(lineH);
  end;
  header := header + chr(206);

  for i := 0 to col2 - 1 do
  begin
    header := header + chr(lineH);
  end;
  header := header + chr(206);

  for i := 0 to col3 - 1 do
  begin
    header := header + chr(lineH);
  end;
  header := header + chr(206);

  for i := 0 to col4 - 1  do
  begin
    header := header + chr(lineH);
  end;
  header := header + chr(206);

  for i := 0 to col5 - 1 do
  begin
    header := header + chr(lineH);
  end;
  header := header + chr(185) + #13#10 + chr(LineV);

  for j := 0 to count do
  begin
    for i := 1 to 5 do
    begin
      if i = 1 then
       begin
        head := IntToStr(List.Messages[j].getNumber);
        col := col1;
        end

      else if i = 2 then
        begin
          head := List.Messages[j].getDate;
          col := col2;
        end
      else if i = 3 then
        begin
          head := List.Messages[j].getName;
          col  := col3;
        end
      else if i = 4 then
        begin
          head := List.Messages[j].getVersion;
          col := col4;
        end
      else
        begin
          head := List.Messages[j].getCode;
          col := col5
        end;

      if(Length(head) <= col) then
        begin
          space := col - Length(head);
          Rspace := Floor(space / 2);
          Lspace := Rspace;

          for k := 0 to Rspace - 1 do
            header := header + ' ';
            header := header + head;

          if (space mod 2) = 0 then
            begin
              for k := 0 to LSpace - 1 do
                header := header + ' ';
            end
          else
            begin
              for k := 0 to LSpace do
              header := header + ' ';
          end;
        end;
      header := header + chr(LineV);
    end;
    header := header + #13#10;
    // draw top buttom
    if (j = count) then
    begin
      header := header + chr(200);
      for m := 0 to col1 - 1 do
        begin
          header :=  header + chr(lineH);
        end;
      header := header + chr(202);

      for m := 0 to col2 - 1 do
        begin
          header := header + chr(lineH);
        end;
      header := header + chr(202);

      for m := 0 to col3 - 1 do
        begin
          header := header + chr(lineH);
        end;
      header := header + chr(202);

      for m := 0 to col4 - 1 do
        begin
          header := header + chr(lineH);
        end;
      header := header + chr(202);

      for m := 0 to col5 - 1 do
        begin
          header := header + chr(lineH);
        end;
      header := header + chr(188) + #13#10;
    end
    else
    begin
      header := header + chr(204);
      for m := 0 to col1 - 1 do
        begin
          header :=  header + chr(lineH);
        end;
          header := header + chr(206);

      for m := 0 to col2 - 1  do
        begin
          header := header + chr(lineH);
        end;
          header := header + chr(206);

      for m := 0 to col3 - 1 do
        begin
          header := header + chr(lineH);
        end;
          header := header + chr(206);

      for m := 0 to col4 - 1 do
        begin
          header := header + chr(lineH);
       end;
          header := header + chr(206);

      for m := 0 to col5 - 1 do
        begin
          header := header + chr(lineH);
      end;
        header := header + chr(185) + #13#10 + chr(LineV);
    end;

  end;
  //Result := IntToStr(col1) +  ' ' + IntToStr(col2) +  ' ' + IntToStr(col3) +  ' ' + IntToStr(col4) +  ' ' + IntToStr(col5) ;
  Result := header;
end;
end.
