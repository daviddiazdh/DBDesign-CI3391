import pandas as pd

# Cargar el archivo Excel
df = pd.read_excel("datos_proy2.xlsx", sheet_name=2, engine="openpyxl")  # O usa pd.read_csv("datos.csv")

# Devuelve: "numero_solicitud", "Prioridad extranjera 2",

columnas_a_excluir = [ "Fecha", "id_marca", "query", "query dated", "Tipo", "Clase",  "Distingue", "tipo de signo", "Num Registro", "Fecha Registro", 
                        "Fecha Vencimiento", "Signo", "Estado", "Tramitante/Agente", "Numero poder", "link_numero_solicitud", 
                        "Tabla", "Descripción etiqueta", "Info Adicional", "Codigo", "Nombre titular", "Domicilio titular", "Nacionalidad titular", 
                        "Fecha Registro 1", "Fecha Vencimiento registro", "Nro documento ultima operacion", "Ultima operacion", "Fecha pago registro", 
                        "Comentarios", "Link comprobante recepcion", "vacio1", "vacio2", "vacio3", "id solicitante1", "id solicitante2", "id solicitante3",
                        "País 1", "Fecha 1", "País 2","Prioridad extranjera 1",  "Fecha 2"]  # Lista de columnas a excluir
df = df.drop(columns=columnas_a_excluir)

# Nombre de la tabla
tabla = "bichito"

#df["Fecha"] = df["Fecha"].dt.date


# Generar sentencias INSERT
sql_script = f"INSERT INTO {tabla} ({', '.join(df.columns)}) VALUES\n"

values = []
for _, row in df.iterrows():
    """
    for col, x in zip(df.columns, row):  # Iteramos sobre cada columna y su valor
        if col == "Fecha" and pd.notna(x): # Si la columna es "nombre", modificar el valor
            x = x.strftime("%Y-%m-%d")
    """
    row_values = ', '.join(f"'{x}'" if isinstance(x, str) else str(x) for x in row)
    values.append(f"({row_values})")

sql_script += ",\n".join(values) + ";\n"

# Guardar en un archivo .sql
with open("prioriza2.sql", "w", encoding="utf-8") as f:
    f.write(sql_script)

print("Archivo SQL generado correctamente.")