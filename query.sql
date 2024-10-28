CREATE DATABASE Prueba;
GO

USE Prueba;
GO

-- Tabla: Beneficiario
CREATE TABLE Beneficiario (
    ID_Beneficiario INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Apellidos NVARCHAR(100),
    FechaNacimiento DATE,
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(20),
    CorreoElectronico NVARCHAR(100),
    Genero NVARCHAR(20),
    EstadoCivil NVARCHAR(20),
    NumeroIdentificacion NVARCHAR(50) UNIQUE,
    FechaRegistro DATE,
    NotasAdicionales NVARCHAR(MAX)
);

-- Tabla: Programa de Asistencia
CREATE TABLE ProgramaAsistencia (
    ID_Programa INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    Objetivos NVARCHAR(MAX),
    FechaInicio DATE,
    FechaFin DATE,
    Responsable NVARCHAR(100)
);

-- Relación: BeneficiarioProgramaAsistencia (Tabla intermedia)
CREATE TABLE BeneficiarioProgramaAsistencia (
    ID_Beneficiario INT,
    ID_Programa INT,
    PRIMARY KEY (ID_Beneficiario, ID_Programa),
    FOREIGN KEY (ID_Beneficiario) REFERENCES Beneficiario(ID_Beneficiario),
    FOREIGN KEY (ID_Programa) REFERENCES ProgramaAsistencia(ID_Programa)
);

-- Tabla: Proyecto
CREATE TABLE Proyecto (
    ID_Proyecto INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    Objetivos NVARCHAR(MAX),
    FechaInicio DATE,
    FechaFin DATE,
    Presupuesto DECIMAL(18, 2),
    Responsable NVARCHAR(100),
    Estado NVARCHAR(20)
);

-- Relación: ProyectoInformeImpacto (Tabla intermedia para Informes de Impacto)
CREATE TABLE ProyectoInformeImpacto (
    ID_Informe INT PRIMARY KEY IDENTITY,
    ID_Proyecto INT,
    FechaCreacion DATE,
    Resultados NVARCHAR(MAX),
    Recomendaciones NVARCHAR(MAX),
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto)
);
-- Tabla: Recurso
CREATE TABLE Recurso (
    ID_Recurso INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Tipo NVARCHAR(50),
    Cantidad INT,
    FechaAdquisicion DATE,
    Estado NVARCHAR(50)
);

-- Relación: ProyectoRecurso (Tabla intermedia para Recursos Asignados)
CREATE TABLE ProyectoRecurso (
    ID_Proyecto INT,
    ID_Recurso INT,
    PRIMARY KEY (ID_Proyecto, ID_Recurso),
    FOREIGN KEY (ID_Proyecto) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ID_Recurso) REFERENCES Recurso(ID_Recurso)
);


-- Tabla: Actividad
CREATE TABLE Actividad (
    ID_Actividad INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    FechaHora DATETIME,
    Lugar NVARCHAR(200),
    ProyectoAsociado INT,
    ProgramaAsociado INT,
    Estado NVARCHAR(20),
    FOREIGN KEY (ProyectoAsociado) REFERENCES Proyecto(ID_Proyecto),
    FOREIGN KEY (ProgramaAsociado) REFERENCES ProgramaAsistencia(ID_Programa)
);

-- Relación: ActividadBeneficiario (Beneficiarios en Actividades)
CREATE TABLE ActividadBeneficiario (
    ID_Actividad INT,
    ID_Beneficiario INT,
    PRIMARY KEY (ID_Actividad, ID_Beneficiario),
    FOREIGN KEY (ID_Actividad) REFERENCES Actividad(ID_Actividad),
    FOREIGN KEY (ID_Beneficiario) REFERENCES Beneficiario(ID_Beneficiario)
);
-- Tabla: Voluntario
CREATE TABLE Voluntario (
    ID_Voluntario INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Apellidos NVARCHAR(100),
    FechaNacimiento DATE,
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(20),
    CorreoElectronico NVARCHAR(100),
    Habilidades NVARCHAR(MAX),
    Disponibilidad NVARCHAR(20)
);
-- Relación: ActividadVoluntario (Voluntarios en Actividades)
CREATE TABLE ActividadVoluntario (
    ID_Actividad INT,
    ID_Voluntario INT,
    PRIMARY KEY (ID_Actividad, ID_Voluntario),
    FOREIGN KEY (ID_Actividad) REFERENCES Actividad(ID_Actividad),
    FOREIGN KEY (ID_Voluntario) REFERENCES Voluntario(ID_Voluntario)
);


-- Tabla: Donante
CREATE TABLE Donante (
    ID_Donante INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Apellidos NVARCHAR(100),
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(20),
    CorreoElectronico NVARCHAR(100),
    Tipo NVARCHAR(50),
    NotasAdicionales NVARCHAR(MAX)
);

-- Tabla: Donacion
CREATE TABLE Donacion (
    ID_Donacion INT PRIMARY KEY IDENTITY,
    ID_Donante INT,
    Monto DECIMAL(18, 2),
    Fecha DATE,
    Metodo NVARCHAR(50),
    FOREIGN KEY (ID_Donante) REFERENCES Donante(ID_Donante)
);

-- Tabla: Campaña de Recaudación
CREATE TABLE CampañaRecaudacion (
    ID_Campaña INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    ObjetivoRecaudacion DECIMAL(18, 2),
    FechaInicio DATE,
    FechaFin DATE,
    Responsable NVARCHAR(100)
);

-- Relación: CampañaDonacion
CREATE TABLE CampañaDonacion (
    ID_Campaña INT,
    ID_Donacion INT,
    PRIMARY KEY (ID_Campaña, ID_Donacion),
    FOREIGN KEY (ID_Campaña) REFERENCES CampañaRecaudacion(ID_Campaña),
    FOREIGN KEY (ID_Donacion) REFERENCES Donacion(ID_Donacion)
);

-- Tabla: Personal
CREATE TABLE Personal (
    ID_Personal INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Apellidos NVARCHAR(100),
    FechaNacimiento DATE,
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(20),
    CorreoElectronico NVARCHAR(100),
    Cargo NVARCHAR(100),
    Departamento NVARCHAR(100),
    FechaContratacion DATE,
    Salario DECIMAL(18, 2)
);

-- Tabla: PersonalEvaluacion
CREATE TABLE PersonalEvaluacion (
    ID_Evaluacion INT PRIMARY KEY IDENTITY,
    ID_Personal INT,
    FechaEvaluacion DATE,
    Evaluador NVARCHAR(100),
    Resultados NVARCHAR(MAX),
    Recomendaciones NVARCHAR(MAX),
    FOREIGN KEY (ID_Personal) REFERENCES Personal(ID_Personal)
);

-- Tabla: Evento
CREATE TABLE Evento (
    ID_Evento INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    FechaHora DATETIME,
    Lugar NVARCHAR(255),
    Responsable NVARCHAR(100),
    Estado NVARCHAR(50)
);

-- Relación: EventoParticipante
CREATE TABLE EventoParticipante (
    ID_Evento INT,
    ID_Beneficiario INT,
    PRIMARY KEY (ID_Evento, ID_Beneficiario),
    FOREIGN KEY (ID_Evento) REFERENCES Evento(ID_Evento),
    FOREIGN KEY (ID_Beneficiario) REFERENCES Beneficiario(ID_Beneficiario)
);

-- Relación: EventoMaterial
CREATE TABLE EventoMaterial (
    ID_Evento INT,
    Material NVARCHAR(100),
    Cantidad INT,
    PRIMARY KEY (ID_Evento, Material),
    FOREIGN KEY (ID_Evento) REFERENCES Evento(ID_Evento)
);

-- Tabla: Comunicación
CREATE TABLE Comunicacion (
    ID_Comunicacion INT PRIMARY KEY IDENTITY,
    Tipo NVARCHAR(50),
    FechaHora DATETIME,
    Asunto NVARCHAR(100),
    Detalles NVARCHAR(MAX)
);

-- Relación: ComunicacionParticipante
CREATE TABLE ComunicacionParticipante (
    ID_Comunicacion INT,
    ID_Beneficiario INT,
    PRIMARY KEY (ID_Comunicacion, ID_Beneficiario),
    FOREIGN KEY (ID_Comunicacion) REFERENCES Comunicacion(ID_Comunicacion),
    FOREIGN KEY (ID_Beneficiario) REFERENCES Beneficiario(ID_Beneficiario)
);

-- Tabla: Colaboración
CREATE TABLE Colaboracion (
    ID_Colaboracion INT PRIMARY KEY IDENTITY,
    Organizacion NVARCHAR(100),
    Tipo NVARCHAR(50),
    FechaInicio DATE,
    FechaFin DATE,
    Objetivos NVARCHAR(MAX),
    ContactoPrincipal NVARCHAR(100)
);

-- Relación: ColaboracionActividad
CREATE TABLE ColaboracionActividad (
    ID_Colaboracion INT,
    ID_Actividad INT,
    PRIMARY KEY (ID_Colaboracion, ID_Actividad),
    FOREIGN KEY (ID_Colaboracion) REFERENCES Colaboracion(ID_Colaboracion),
    FOREIGN KEY (ID_Actividad) REFERENCES Actividad(ID_Actividad)
);

-- Tabla: Capacitación
CREATE TABLE Capacitacion (
    ID_Capacitacion INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    FechaHora DATETIME,
    Lugar NVARCHAR(255)
);

-- Relación: CapacitacionParticipante
CREATE TABLE CapacitacionParticipante (
    ID_Capacitacion INT,
    ID_Participante INT,
    PRIMARY KEY (ID_Capacitacion, ID_Participante),
    FOREIGN KEY (ID_Capacitacion) REFERENCES Capacitacion(ID_Capacitacion),
    FOREIGN KEY (ID_Participante) REFERENCES Beneficiario(ID_Beneficiario)
);

-- Relación: CapacitacionMaterial
CREATE TABLE CapacitacionMaterial (
    ID_Capacitacion INT,
    Material NVARCHAR(100),
    Cantidad INT,
    PRIMARY KEY (ID_Capacitacion, Material),
    FOREIGN KEY (ID_Capacitacion) REFERENCES Capacitacion(ID_Capacitacion)
);

-- Tabla: Solicitud de Asistencia
CREATE TABLE SolicitudAsistencia (
    ID_Solicitud INT PRIMARY KEY IDENTITY,
    ID_Beneficiario INT,
    FechaSolicitud DATE,
    Estado NVARCHAR(50),
    Descripcion NVARCHAR(MAX),
    FOREIGN KEY (ID_Beneficiario) REFERENCES Beneficiario(ID_Beneficiario)
);

-- Tabla: Informe Financiero
CREATE TABLE InformeFinanciero (
    ID_Informe INT PRIMARY KEY IDENTITY,
    Periodo NVARCHAR(50),
    FechaCreacion DATE,
    Ingresos DECIMAL(18, 2),
    Gastos DECIMAL(18, 2),
    Balance DECIMAL(18, 2)
);

-- Tabla: InformeFinancieroAuditoria
CREATE TABLE InformeFinancieroAuditoria (
    ID_Auditoria INT PRIMARY KEY IDENTITY,
    ID_Informe INT,
    FechaAuditoria DATE,
    Resultados NVARCHAR(MAX),
    Recomendaciones NVARCHAR(MAX),
    FOREIGN KEY (ID_Informe) REFERENCES InformeFinanciero(ID_Informe)
);

-- Tabla: Actividad de Recaudación
CREATE TABLE ActividadRecaudacion (
    ID_Actividad INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    FechaHora DATETIME,
    Lugar NVARCHAR(255),
    Responsable NVARCHAR(100)
);

-- Relación: ActividadRecaudacionDonacion
CREATE TABLE ActividadRecaudacionDonacion (
    ID_Actividad INT,
    ID_Donacion INT,
    PRIMARY KEY (ID_Actividad, ID_Donacion),
    FOREIGN KEY (ID_Actividad) REFERENCES ActividadRecaudacion(ID_Actividad),
    FOREIGN KEY (ID_Donacion) REFERENCES Donacion(ID_Donacion)
);

-- Tabla: Política
CREATE TABLE Politica (
    ID_Politica INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    FechaImplementacion DATE,
    Responsable NVARCHAR(100)
);

-- Tabla: Seguimiento
CREATE TABLE Seguimiento (
    ID_Seguimiento INT PRIMARY KEY IDENTITY,
    ID_Beneficiario INT,
    FechaSeguimiento DATE,
    Observaciones NVARCHAR(MAX),
    FOREIGN KEY (ID_Beneficiario) REFERENCES Beneficiario(ID_Beneficiario)
);
