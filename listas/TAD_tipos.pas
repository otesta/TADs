unit TAD_tipos;

interface
 Type Campo_Comparar = (campo1, campo2, campo3, campo1y2, campo1y3, campo2y3, campo123);
 Comparacion = (menor, igual, mayor, distinto, error);
 Errores = (Vacio, LLeno, PosicionInvalida, Otro, OK);
 TipoElemento = Object
        DS: String;
        DN: LongInt;
        DR: Real;
        DV: Variant;
        DP: Pointer;
        Procedure Inicializar;
        Procedure Azar(N: Integer);
        Procedure AsignarValores(X: TipoElemento);
        Function CompararTE(X2:TipoElemento; Comparar:Campo_Comparar):Comparacion;
 End;

implementation

Procedure TipoElemento.Inicializar;
Begin
        DS := '';
        DN := 0;
        DR := 0.0;
End;

Procedure TipoElemento.Azar(N: Integer);
 Begin
        DN := Random(N);
 End;

Procedure TipoElemento.AsignarValores(X: TipoElemento);
Begin
        DN := X.DN;
        DS := X.DS;
        DR := X.DR;
        DV := X.DV;
        DP := X.DP;
End;

 Function TipoElemento.CompararTE(X2:TipoElemento;Comparar:Campo_Comparar):Comparacion;
 Begin
 CompararTE := distinto;
 Case Comparar Of
        campo1: If DS = X2.DS Then
                CompararTE := igual
 Else
        If DS < X2.DS Then
                CompararTE := menor
 Else
        CompararTE := mayor;
        campo2: If DN = X2.DN Then
                CompararTE := igual
 Else
        If DN < X2.DN Then
                CompararTE := menor
 Else
        CompararTE := mayor;
        campo3: If DR = X2.DR Then
                CompararTE := igual
 Else
        If DR < X2.DR Then
        CompararTE := menor
 Else
                CompararTE := mayor;
        campo1y2: If (DS = X2.DS) And (DN = X2.DN ) Then
                CompararTE := igual;
        campo1y3: If (DS = X2.DS) And (DR = X2.DR ) Then
                CompararTE := igual;
        campo2y3: If (DN = X2.DN) And (DR = X2.DR ) Then
                CompararTE := igual;
        campo123: If (DS = X2.DS) And (DN = X2.DN ) And (DR = X2.DR) Then
                CompararTE := igual;
        Else
                CompararTE := error;
        end;
 end;


end.