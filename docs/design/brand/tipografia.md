# Tipografia — Dia A Dia

**Projeto:** Dia A Dia
**Slogan:** Seu dia mais organizado
**Status:** Aprovada — versão 1.0
**Última revisão:** 04/08/2026

---

## 1. Objetivo

Definir e documentar a tipografia oficial do aplicativo **Dia A Dia**, estabelecendo uma base consistente para:

* Hierarquia visual;
* Legibilidade;
* Organização das informações;
* Títulos;
* Textos;
* Datas e horários;
* Labels;
* Botões;
* Informações auxiliares;
* Informações climáticas;
* Design System.

A definição tipográfica considera principalmente:

* Legibilidade em dispositivos móveis;
* Hierarquia visual;
* Acessibilidade;
* Consistência;
* Facilidade de manutenção;
* Personalidade visual do produto.

---

# 2. Família Tipográfica

A família tipográfica oficial do Dia A Dia é:

> **Manrope**

A Manrope será utilizada como fonte principal em toda a interface do aplicativo.

### Características desejadas

A tipografia deve contribuir para uma interface:

* Moderna;
* Amigável;
* Limpa;
* Legível;
* Contemporânea;
* Organizada.

A escolha complementa a identidade visual baseada em:

> **Azul Sereno + Amarelo Solar**

O azul transmite organização, confiança, tranquilidade e foco.

A Manrope acrescenta uma característica mais humana e moderna, evitando que o produto tenha aparência excessivamente corporativa.

---

# 3. Direção Tipográfica

A tipografia do Dia A Dia deve transmitir:

> **Organização sem rigidez e produtividade sem excesso de formalidade.**

A fonte deve favorecer uma experiência:

* Clara;
* Leve;
* Moderna;
* Organizada;
* Amigável.

A personalidade visual do aplicativo não deve depender exclusivamente da tipografia.

Ela será construída pela combinação entre:

```text
Identidade Visual
│
├── Azul Sereno
├── Amarelo Solar
├── Elementos gráficos
└── Manrope
```

---

# 4. Aplicação Global

A Manrope deve ser configurada como **fonte global do aplicativo através do `AppTheme`**.

A fonte não deve ser aplicada individualmente em cada widget.

### Arquitetura visual

```text
AppTheme
    ↓
TextTheme
    ↓
Componentes
    ↓
Telas
```

### Regra

Preferir a utilização dos estilos definidos no `TextTheme`.

Evitar chamadas diretas da fonte espalhadas pelos widgets.

Exemplo a evitar:

```dart
GoogleFonts.manrope(
  fontSize: 16,
)
```

em vários componentes diferentes.

Preferir:

```text
Theme.of(context).textTheme.bodyMedium
```

ou o equivalente definido pelo Design System.

### Objetivo

A centralização permite:

* Consistência;
* Manutenção simplificada;
* Alterações centralizadas;
* Menor duplicação;
* Padronização;
* Evolução futura do Design System.

---

# 5. Escala Tipográfica

A escala tipográfica oficial da versão 1.0 é:

| Estilo         | Tamanho | Peso     | Line Height | Uso                        |
| -------------- | ------: | -------- | ----------: | -------------------------- |
| **Display**    |   32 px | Bold     |       40 px | Destaques excepcionais     |
| **H1**         |   28 px | Bold     |       36 px | Títulos principais         |
| **H2**         |   22 px | SemiBold |       30 px | Títulos de seção           |
| **H3**         |   18 px | SemiBold |       26 px | Subtítulos                 |
| **Body**       |   16 px | Regular  |       24 px | Conteúdo principal         |
| **Body Small** |   14 px | Regular  |       20 px | Informações secundárias    |
| **Label**      |   14 px | SemiBold |       20 px | Botões, chips e categorias |
| **Caption**    |   12 px | Medium   |       16 px | Informações auxiliares     |

> **Nota:** os valores representam a especificação visual. A implementação deverá utilizar os equivalentes adequados do `TextTheme` do Flutter.

---

# 6. Display

**32 px / Bold / 40 px**

Utilizado para informações que precisam de destaque excepcional.

Exemplos possíveis:

```text
24°
```

na área de previsão do tempo ou outros dados de grande importância visual.

### Regra

O Display não deve ser utilizado constantemente.

Seu objetivo é criar **destaque excepcional**, e não substituir os títulos normais da interface.

---

# 7. H1 — Título Principal

**28 px / Bold / 36 px**

Utilizado para o título principal de uma tela ou contexto.

Exemplos:

```text
Bom dia!

Minhas tarefas

Planeje seu dia
```

O H1 deve estabelecer imediatamente a hierarquia principal da tela.

---

# 8. H2 — Título de Seção

**22 px / SemiBold / 30 px**

Utilizado para separar grupos importantes de conteúdo.

Exemplos:

```text
Hoje

Próximas tarefas

Previsão do tempo

Atividades recentes
```

O H2 deve possuir menor destaque que o H1, mantendo uma hierarquia visual clara.

---

# 9. H3 — Subtítulo

**18 px / SemiBold / 26 px**

Utilizado para subdivisões dentro de uma seção.

Exemplos:

```text
Manhã

Tarde

Noite
```

Também pode ser utilizado em títulos de componentes que não representam uma seção principal da tela.

---

# 10. Body

**16 px / Regular / 24 px**

É o estilo principal de conteúdo textual.

Utilização prevista:

* Nome de tarefas;
* Descrições;
* Textos explicativos;
* Mensagens;
* Conteúdo geral;
* Informações relevantes.

O Body 16/24 é considerado a **referência principal de legibilidade** do sistema.

### Regra

O tamanho de 16 px deve ser priorizado para conteúdos que precisam ser confortáveis de ler em dispositivos móveis.

---

# 11. Body Small

**14 px / Regular / 20 px**

Utilizado para informações secundárias.

Exemplos:

```text
Hoje, 08:30

Trabalho

Última atualização há 5 min
```

Deve possuir menor destaque que o Body, mas continuar confortável para leitura.

### Regra

Não utilizar Body Small apenas para economizar espaço quando a informação for essencial para a execução de uma ação.

---

# 12. Label

**14 px / SemiBold / 20 px**

Utilizado em elementos de interação e identificação.

Exemplos:

* Botões;
* Chips;
* Categorias;
* Filtros;
* Labels de campos;
* Controles.

Exemplos:

```text
Adicionar tarefa

Salvar

Trabalho

Estudo

Pessoal

Saúde
```

Labels devem permanecer curtos e facilmente identificáveis.

---

# 13. Caption

**12 px / Medium / 16 px**

Utilizado para informações auxiliares de baixa prioridade.

Exemplos:

```text
Atualizado às 08:30

Última sincronização

Informação adicional
```

### Regra

O Caption não deve ser utilizado para informações essenciais à realização de uma ação.

---

# 14. Pesos Tipográficos

A aplicação utilizará principalmente quatro pesos:

| Peso         | Uso                                          |
| ------------ | -------------------------------------------- |
| **Regular**  | Texto principal                              |
| **Medium**   | Pequenas ênfases e informações auxiliares    |
| **SemiBold** | Títulos intermediários, labels e componentes |
| **Bold**     | Títulos principais e destaques               |

### Regra

Os pesos devem criar hierarquia visual.

Evitar utilizar `Bold` excessivamente.

A interface deve permanecer leve e organizada.

---

# 15. Letter Spacing

O projeto não terá, inicialmente, valores personalizados de `letterSpacing` para cada estilo.

Será utilizado o comportamento padrão da Manrope.

Ajustes específicos poderão ser realizados futuramente somente quando houver necessidade visual ou de acessibilidade comprovada.

### Objetivo

Evitar microajustes desnecessários e manter a tipografia simples de manter.

---

# 16. Hierarquia Visual

A hierarquia não deve depender apenas do tamanho da fonte.

Ela será construída através da combinação de:

```text
Tamanho
+
Peso
+
Line Height
+
Cor
+
Espaçamento
```

Exemplo conceitual:

```text
H1
28 px / Bold
Text Primary

H2
22 px / SemiBold
Text Primary

Body
16 px / Regular
Text Primary

Body Small
14 px / Regular
Text Secondary

Caption
12 px / Medium
Text Secondary
```

Isso permite criar hierarquia sem depender de tamanhos exagerados.

---

# 17. Datas e Horários

Datas e horários são informações fundamentais para o Dia A Dia.

Exemplos:

```text
04 de agosto

08:30

Hoje

Amanhã
```

Essas informações devem possuir boa legibilidade e hierarquia adequada.

O horário não deve ser reduzido excessivamente quando representar uma informação importante da tarefa.

---

# 18. Informações Climáticas

A tipografia também deve estabelecer hierarquia nas informações climáticas.

Exemplo:

```text
24°
Belo Horizonte
Ensolarado
```

A temperatura pode receber maior destaque visual, enquanto local e condição climática funcionam como informações complementares.

Hierarquia recomendada:

```text
Temperatura
    ↓
Condição climática
    ↓
Local
    ↓
Informações adicionais
```

A informação climática deve complementar a experiência de organização da rotina, sem assumir o protagonismo da interface.

---

# 19. Acessibilidade

A tipografia deve ser aplicada considerando acessibilidade desde o início.

### Regras

* Priorizar legibilidade;
* Evitar tamanhos excessivamente pequenos;
* Manter contraste adequado;
* Não depender apenas de peso para transmitir significado;
* Evitar textos excessivamente condensados;
* Utilizar line height adequado;
* Não utilizar letras maiúsculas excessivamente em textos longos;
* Não utilizar `Caption` para informações essenciais.

### Tamanho mínimo

O estilo `Caption` possui 12 px e deve ser reservado para informações auxiliares.

Conteúdo principal deve priorizar **16 px ou mais** sempre que possível.

---

# 20. Responsividade

A escala tipográfica deve funcionar em diferentes tamanhos de tela.

A hierarquia não deve depender de uma única resolução.

Devem ser considerados:

* Smartphones pequenos;
* Smartphones médios;
* Smartphones grandes;
* Orientação do dispositivo;
* Quebra de linha;
* Conteúdos longos;
* Acessibilidade e aumento de tamanho de fonte do sistema.

A tipografia deve continuar funcional mesmo quando o conteúdo ocupar mais espaço do que o inicialmente previsto.

---

# 21. Regras de Consistência

### Evitar

* Fontes diferentes entre telas;
* Pesos aleatórios;
* Tamanhos definidos individualmente sem necessidade;
* `GoogleFonts.manrope()` espalhado pelos widgets;
* Estilos diferentes para a mesma finalidade;
* Alterações arbitrárias na hierarquia;
* Uso excessivo de Bold;
* Criação de novos tamanhos sem necessidade.

### Preferir

```text
AppTheme
   ↓
TextTheme
   ↓
Estilos semânticos
   ↓
Componentes
   ↓
Telas
```

---

# 22. Mapeamento Conceitual para o Flutter

A implementação deverá utilizar os estilos semânticos disponíveis no `TextTheme`.

Mapeamento conceitual:

| Design System | Flutter                       |
| ------------- | ----------------------------- |
| Display       | `displaySmall` / equivalente  |
| H1            | `headlineLarge`               |
| H2            | `headlineSmall` / equivalente |
| H3            | `titleLarge`                  |
| Body          | `bodyLarge`                   |
| Body Small    | `bodyMedium`                  |
| Label         | `labelLarge`                  |
| Caption       | `bodySmall`                   |

### Observação

O mapeamento acima é uma referência inicial.

Durante a implementação, os estilos deverão ser ajustados para respeitar **os valores definidos na escala tipográfica oficial**, e não simplesmente assumir os valores padrão do Flutter.

---

# 23. Exemplo de Hierarquia em uma Tela

Exemplo conceitual da aplicação:

```text
Bom dia, Roberto!
↑
H1
28 / Bold


Hoje
↑
H2
22 / SemiBold


Estudar Flutter
↑
Body
16 / Regular


19:00 · Estudo
↑
Body Small
14 / Regular


Última atualização às 18:30
↑
Caption
12 / Medium
```

A intenção é que o usuário consiga identificar rapidamente:

1. Onde está;
2. Qual é a seção;
3. Qual é a tarefa;
4. Quando ela acontece;
5. Informações complementares.

---

# 24. Princípios de Uso

A tipografia deve seguir os seguintes princípios:

### 24.1 Legibilidade antes da estética

A fonte deve ser confortável para leitura antes de qualquer preocupação estética.

### 24.2 Hierarquia clara

O usuário deve conseguir identificar rapidamente o que é mais importante.

### 24.3 Consistência

Elementos com a mesma função devem utilizar o mesmo estilo tipográfico.

### 24.4 Moderação

Não utilizar muitos tamanhos e pesos diferentes em uma mesma tela.

### 24.5 Escalabilidade

Os estilos devem funcionar em diferentes telas e quantidades de conteúdo.

### 24.6 Centralização

As decisões tipográficas devem permanecer centralizadas no `AppTheme` / `TextTheme`.

---

# 25. Especificação Oficial — v1.0

```text
Família:
Manrope

Display:
32 px / Bold / 40 px

H1:
28 px / Bold / 36 px

H2:
22 px / SemiBold / 30 px

H3:
18 px / SemiBold / 26 px

Body:
16 px / Regular / 24 px

Body Small:
14 px / Regular / 20 px

Label:
14 px / SemiBold / 20 px

Caption:
12 px / Medium / 16 px

Letter Spacing:
Padrão da Manrope
```

---

# 26. Status da Tipografia

## ✅ Aprovado

* Família: **Manrope**
* Aplicação global através do `AppTheme`
* Escala tipográfica v1.0
* Pesos utilizados
* Line heights
* Uso conceitual de cada nível
* Direção visual
* Princípios de hierarquia
* Princípios de acessibilidade
* Regras de consistência

## ⏳ Validação futura

A escala está definida, mas deverá ser validada quando os primeiros componentes forem desenvolvidos.

A validação deverá observar:

* Legibilidade real;
* Hierarquia;
* Quebra de linhas;
* Diferentes tamanhos de tela;
* Acessibilidade;
* Integração com a paleta;
* Densidade das telas.

Caso os testes indiquem problemas, a escala poderá sofrer ajustes em uma nova versão.

---

# 27. Decisão Final

A tipografia oficial do **Dia A Dia** é:

> **Manrope**

A versão 1.0 da escala tipográfica foi definida para priorizar:

> **legibilidade + hierarquia + simplicidade + personalidade.**

A tipografia será centralizada no `AppTheme` e utilizada através do `TextTheme`.

A criação de novos estilos tipográficos fora desta especificação deve ser evitada sem justificativa de UX/UI e revisão do Design System.
