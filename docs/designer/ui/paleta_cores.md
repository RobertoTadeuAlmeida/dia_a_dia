# Paleta de Cores — Dia A Dia

**Projeto:** Dia A Dia
**Slogan:** Seu dia mais organizado
**Status:** Aprovada — versão inicial
**Última revisão:** 04/08/2026

---

## 1. Objetivo

Definir e documentar a paleta de cores oficial do aplicativo **Dia A Dia**, estabelecendo cores consistentes para:

* Identidade visual;
* Interface do aplicativo;
* Elementos primários;
* Estados do sistema;
* Categorias de tarefas;
* Fundos e superfícies;
* Textos e informações auxiliares.

A paleta foi definida considerando **usabilidade, hierarquia visual, legibilidade, acessibilidade e consistência entre componentes**.

---

# 2. Direção Visual

A direção visual escolhida para o Dia A Dia é:

> **Azul calmo + amarelo solar + neutros claros**

O azul representa os principais atributos do produto:

* Organização;
* Confiança;
* Tranquilidade;
* Foco;
* Estabilidade.

O amarelo solar representa:

* Dia;
* Energia;
* Positividade;
* Destaque;
* Relação visual com o conceito de sol presente na identidade da marca.

### Princípio de hierarquia

O azul deve permanecer como **cor dominante da identidade**.

O amarelo solar deve funcionar como **cor de destaque**, e não como uma segunda cor principal.

Os neutros devem ocupar grande parte da interface para preservar uma experiência visual leve e organizada.

---

# 3. Paleta de Identidade

| Token          | Cor           | HEX       | Uso                                                         |
| -------------- | ------------- | --------- | ----------------------------------------------------------- |
| `primary`      | Azul Sereno   | `#4169A1` | Cor principal da identidade e ações primárias               |
| `primaryDark`  | Azul Escuro   | `#2F4F7A` | Contraste e elementos de maior destaque                     |
| `primaryLight` | Azul Claro    | `#E8F0FA` | Fundos suaves, seleções e estados relacionados à identidade |
| `solar`        | Amarelo Solar | `#F5C84B` | Destaques, elementos relacionados ao dia e conceito do sol  |

### 3.1 Primary — `#4169A1`

Cor principal do Dia A Dia.

Deve ser utilizada principalmente em:

* Botões primários;
* Elementos de ação;
* Indicadores selecionados;
* Componentes de navegação;
* Elementos de destaque da interface;
* Elementos relacionados à identidade visual.

O azul deve permanecer como principal referência cromática da aplicação.

---

### 3.2 Primary Dark — `#2F4F7A`

Variação mais escura do azul principal.

Utilização prevista:

* Elementos que necessitem de maior contraste;
* Estados visuais mais fortes;
* Componentes específicos que utilizem uma variação escura da identidade;
* Elementos visuais da marca quando necessário.

Não deve substituir indiscriminadamente o `primary`.

---

### 3.3 Primary Light — `#E8F0FA`

Variação clara do azul principal.

Utilização prevista:

* Fundos suaves;
* Seleções;
* Destaques discretos;
* Backgrounds de componentes relacionados à identidade;
* Estados selecionados que não necessitem de alto contraste.

Seu objetivo é destacar uma área sem gerar excesso de peso visual.

---

### 3.4 Solar — `#F5C84B`

Cor de destaque associada ao conceito de sol e dia.

Utilização prevista:

* Elementos relacionados ao clima;
* Detalhes da identidade visual;
* Destaques pontuais;
* Elementos associados à logo;
* Pequenos elementos que precisem de atenção visual.

### Regra importante

O `solar` **não deve ser utilizado como substituto das cores de estado**, principalmente `warning`.

O amarelo solar representa a identidade do produto e o conceito de dia. Alertas possuem uma cor própria para evitar ambiguidade semântica.

---

# 4. Cores Neutras

Os neutros têm como objetivo criar uma interface limpa e permitir que as cores de identidade e estado sejam utilizadas de forma controlada.

| Token           | Cor              | HEX       | Uso                                 |
| --------------- | ---------------- | --------- | ----------------------------------- |
| `background`    | Background       | `#F8FAFC` | Fundo principal das telas           |
| `surface`       | Surface          | `#FFFFFF` | Cards, containers e superfícies     |
| `textPrimary`   | Texto Principal  | `#1E293B` | Títulos e informações principais    |
| `textSecondary` | Texto Secundário | `#64748B` | Informações auxiliares e descrições |

### 4.1 Background — `#F8FAFC`

Cor padrão para o fundo geral das telas.

A utilização de um branco levemente azulado reduz o contraste excessivo de um branco puro e contribui para uma aparência mais confortável.

---

### 4.2 Surface — `#FFFFFF`

Utilizada para elementos que precisam se destacar do background.

Exemplos:

* Cards;
* Modais;
* Containers;
* Campos;
* Superfícies elevadas.

---

### 4.3 Text Primary — `#1E293B`

Cor destinada às informações de maior importância.

Exemplos:

* Títulos;
* Nome de tarefas;
* Datas;
* Informações principais;
* Conteúdo textual prioritário.

---

### 4.4 Text Secondary — `#64748B`

Cor destinada a informações complementares.

Exemplos:

* Descrições;
* Horários secundários;
* Labels;
* Informações auxiliares;
* Textos de apoio.

---

# 5. Cores de Estado

As cores de estado possuem significado funcional e não fazem parte diretamente da identidade cromática principal.

| Token     | Cor              | HEX       | Significado                                   |
| --------- | ---------------- | --------- | --------------------------------------------- |
| `success` | Verde            | `#2E8B57` | Sucesso, conclusão e confirmação              |
| `error`   | Vermelho         | `#D64545` | Erro, falha e validação inválida              |
| `warning` | Laranja/Âmbar    | `#D99000` | Atenção, risco e situações que exigem revisão |
| `info`    | Azul Informativo | `#3B82B6` | Informação, dicas e mensagens auxiliares      |

---

## 5.1 Success — `#2E8B57`

Utilizada para representar operações concluídas com sucesso.

Exemplos:

* Tarefa concluída;
* Cadastro realizado;
* Dados salvos;
* Operação confirmada.

---

## 5.2 Error — `#D64545`

Utilizada para situações de erro.

Exemplos:

* Campo inválido;
* Falha de operação;
* Erro de autenticação;
* Problemas de conexão;
* Operações que não puderam ser concluídas.

---

## 5.3 Warning — `#D99000`

Utilizada para situações que requerem atenção.

Exemplos:

* Tarefas atrasadas;
* Informações que precisam ser revisadas;
* Situações potencialmente problemáticas;
* Alertas relacionados à previsão do tempo.

### Regra

O `warning` não deve utilizar o `solar`.

O `solar` possui significado de **identidade/dia**, enquanto `warning` possui significado funcional de **atenção**.

---

## 5.4 Info — `#3B82B6`

Utilizada para informações que não representam erro, sucesso ou alerta.

Exemplos:

* Informações meteorológicas;
* Dicas;
* Mensagens informativas;
* Explicações auxiliares.

O `info` é diferente do `primary` para evitar que mensagens informativas sejam confundidas com ações principais.

---

# 6. Cores das Categorias

As categorias possuem cores próprias para facilitar a identificação visual das tarefas.

| Categoria | Cor        | HEX       | Associação                  |
| --------- | ---------- | --------- | --------------------------- |
| Trabalho  | Azul       | `#4F6FA8` | Profissionalismo e foco     |
| Estudo    | Roxo       | `#8064A2` | Conhecimento e criatividade |
| Pessoal   | Verde/Teal | `#4E8B78` | Equilíbrio e vida pessoal   |
| Saúde     | Coral      | `#C86B6B` | Cuidado e saúde             |

### 6.1 Trabalho — `#4F6FA8`

Representa atividades profissionais, compromissos de trabalho e responsabilidades relacionadas à carreira.

---

### 6.2 Estudo — `#8064A2`

Representa atividades acadêmicas e de aprendizado.

**Observação:** a tonalidade roxa foi aprovada para a versão atual da paleta, mas permanece como ponto sujeito a revisão futura caso não apresente boa integração com a identidade visual completa.

---

### 6.3 Pessoal — `#4E8B78`

Representa atividades pessoais, compromissos particulares e tarefas relacionadas à vida cotidiana.

---

### 6.4 Saúde — `#C86B6B`

Representa atividades relacionadas à saúde, bem-estar e cuidados pessoais.

---

# 7. Regras de Uso das Categorias

As cores de categoria devem funcionar como **indicadores visuais**, e não como cores predominantes da interface.

Preferencialmente, devem aparecer em:

* Indicadores;
* Ícones;
* Pequenos detalhes;
* Badges;
* Filtros;
* Elementos de identificação da categoria.

### Evitar

Não utilizar a cor da categoria para preencher completamente cards ou grandes áreas da interface sem necessidade.

Exemplo recomendado:

```text
┌──────────────────────────────────┐
│ ●  Estudar Flutter               │
│    19:00 · Estudo                │
└──────────────────────────────────┘
```

O indicador pode utilizar a cor da categoria enquanto a estrutura permanece neutra.

---

# 8. Cor Não Deve Ser o Único Indicador

A cor não deve ser utilizada como único meio de comunicação de informação.

Sempre que possível, categorias e estados devem possuir também:

* Ícone;
* Texto;
* Forma;
* Label;
* Indicador visual adicional.

Exemplo:

```text
📚 Estudo
```

em vez de depender exclusivamente de:

```text
🟣
```

Essa regra melhora a acessibilidade e reduz a possibilidade de confusão entre categorias e estados.

---

# 9. Hierarquia Cromática

A aplicação deve seguir aproximadamente esta hierarquia:

```text
1. Neutros
   ↓
2. Azul Sereno
   ↓
3. Amarelo Solar
   ↓
4. Cores de categoria
   ↓
5. Cores de estado
```

### Princípio

A interface deve permanecer predominantemente neutra e azul.

As cores mais fortes devem aparecer apenas quando possuem uma função clara.

O objetivo é evitar excesso de estímulos visuais e manter a experiência do usuário organizada.

---

# 10. Princípios de Acessibilidade

A aplicação deverá considerar acessibilidade durante a implementação da paleta.

As cores não devem ser avaliadas somente pela aparência, mas também pelo contraste e pela capacidade de comunicar informações de maneira clara.

### Regras

* Não utilizar cor como único indicador de estado.
* Não utilizar texto com baixo contraste sobre backgrounds claros.
* Validar contraste entre texto e superfície.
* Validar contraste de componentes interativos.
* Utilizar ícones ou labels para complementar estados e categorias.
* Evitar combinações de cores que possam ser difíceis de distinguir para usuários com deficiência de visão de cores.

A validação formal de contraste deverá ser realizada antes da implementação definitiva do Design System.

---

# 11. Proporção Visual

A aplicação deve priorizar:

```text
Neutros       ████████████████████████████
Azul          ███████
Amarelo       ██
Categorias    ██
Estados       ██
```

A proporção não representa uma regra matemática rígida, mas uma orientação de composição.

Como princípio geral:

> **Azul identifica o produto. Neutros estruturam a interface. Amarelo destaca. Categorias organizam. Estados comunicam.**

---

# 12. Status da Paleta

### Aprovado

* Direção: **Azul calmo + amarelo solar**
* Primary
* Primary Dark
* Primary Light
* Solar
* Background
* Surface
* Text Primary
* Text Secondary
* Success
* Error
* Warning
* Info
* Cores das quatro categorias

### Observação

A cor da categoria **Estudo (`#8064A2`)** foi aprovada, porém identificada como possível ponto de revisão futura.

A paleta poderá sofrer ajustes de tonalidade após testes de:

* Contraste;
* Acessibilidade;
* Aplicação em componentes reais;
* Modo claro/escuro;
* Integração com a identidade visual completa.

Até que esses testes sejam realizados, esta documentação representa a **paleta visual de referência do projeto**.
