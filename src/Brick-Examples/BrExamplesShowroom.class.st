"
I am a collection of ""showroom"" examples.

! Buttons

In the example below we show all existing button styles
${example:BrExamplesShowroom class>>#allButtons|expanded|noCode}$

The following glamorous button reacts to various UI interaction events and changes its style according the state (pressed, hovered)
${example:BrExamplesShowroom>>#glamorousButton}$

Button can also be disabled to prevent click events
${example:BrExamplesShowroom>>#glamorousDisabledButton}$

! Toggles

Toggle buttons can have radically different look, while the behaviour of all of them is exactly the same.
${example:BrExamplesShowroom class>>#allToggles|noCode}$

!! Labelled toggle

To create a toggle button with a label user should the corresponding  ${class:BrMaterialToggleWithIconLook}$

${example:BrExamplesShowroom>>#materialLabelToggle}$

!! Iconified toggle

Similarly we can use the icon look to build an iconified toggle:
${example:BrExamplesShowroom>>#materialIconToggle}$

!! Iconified labelled toggle

We can compose label and icon looks to create a toggle button with both label and the icon. Note that the order of looks defines the visual order of the label and icon:

${example:BrExamplesShowroom>>#materialToggle}$

Thus being said by swapping the label and icon look we can move the icon to the right from the label:

${example:BrExamplesShowroom>>#materialReversedToggle}$

! Accordion

Accordion is the exandable and collapsable widget that consists of a header and a content. Any visual ${class:BlElement}$ can be a header of the accordion. The following example shows how a ${class:BrButton}$ can be used an accordion header:

${example:BrExamplesShowroom>>#accordion}$

! Tabs

The following example shows how to create a tab group widget with 3 tabs. The content of each tab is defined with the help of a stencil.

${example:BrExamplesShowroom>>#glamorousTabs}$

! Toolbar

The toolbar is a logical set of action buttons (either labelled or iconified).
${example:BrExamplesShowroom>>#glamorousToolbar}$
${example:BrExamplesShowroom>>#materialToolbar}$

! List

The example below describes how to instantiate a new instance of the simple list that only has one column:
${example:BrExamplesShowroom>>#simpleList|noCode}$

${example:BrExamplesShowroom>>#columnedList|noCode}$











"
Class {
	#name : #BrExamplesShowroom,
	#superclass : #Object,
	#category : #'Brick-Examples-! Showroom'
}

{ #category : #buttons }
BrExamplesShowroom class >> allButtons [
	<gtExample>

	^ BlElement new
		layout: (BlGridLayout new cellSpacing: 30);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent
		];
		addChildren: { 
			self new glamorousButton.
			self new glamorousDisabledButton.
			self new materialButton
		}
]

{ #category : #buttons }
BrExamplesShowroom class >> allToggles [
	<gtExample>

	^ BlElement new
		layout: (BlGridLayout new cellSpacing: 30; columnCount: 3);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent
		];
		addChildren: { 
			self new hydraToggle.
			self new hydraWithTrackToggle.
			self new hydraWithoutTrackToggle.
			self new materialIconToggle.
			self new materialLabelToggle.
			self new materialToggle
			
		}
]

{ #category : #accordion }
BrExamplesShowroom >> accordion [
	<gtExample>
	| accordion header |

	accordion := BrAccordion new.
	accordion look: BrGlamorousAccordionLook new.
	accordion stencil: [
		BlElement new
			size: 200@100;
			background: Color paleRed ].

	header := BrButton new.
	header look: BrGlamorousAccordionHeaderLook new.
	header label: 'Click to expand/collapse'.
	header action: [ accordion toggle ].

	accordion addChildFirst: header.

	^ accordion
]

{ #category : #accordion }
BrExamplesShowroom >> accordionList [
	<gtExample>
	
	| header children container |
	children := 5 timesCollect: [ :anIndex |
		| accordion |
		accordion := BrAccordion new.
		accordion look: BrGlamorousAccordionLook new.
		accordion margin: (BlInsets all: 5).
		accordion stencil: [
			(GtDocumenter editorForText: 'Hello world')
				constraintsDo: [ :c | c vertical fitContent ] ].

		header := BrButton new.
		header look: BrGlamorousAccordionHeaderLook new.
		header label: 'Header ', anIndex asString .
		header action: [ accordion toggle ].

		accordion addChildFirst: header.
		accordion ].

	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container padding: (BlInsets all: 10).
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	container addChildren: children.
	^ container
]

{ #category : #list }
BrExamplesShowroom >> columnedList [
	<gtExample>
	| aList |

	aList := BrColumnedList new.
	aList column
		stencil: [ :aColor :aRowIndex |
			BlTextElement new
				text: (aRowIndex asRopedText);
				padding: (BlInsets all: 12);
				width: 20 ].
	aList column
		stencil: [ :aColor |
			BlTextElement new
				text: (aColor asString asRopedText foreground: aColor contrastingForegroundColor);
				background: aColor;
				padding: (BlInsets all: 12);
				constraintsDo: [ :c | c horizontal matchParent ] ].

	aList display: (Color indexedColors).

	^ aList
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousButton [
	<gtExample>
	
	^ BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Button';
		action: [ self inform: 'Clicked' ]
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousDisabledButton [
	<gtExample>
	
	^ self glamorousButton
		disable
]

{ #category : #tabs }
BrExamplesShowroom >> glamorousTabs [
	<gtExample>
	<description: 'Tabs with glamorous look'>
	| aTabGroup |

	aTabGroup := BrTabGroup new.
	aTabGroup look: BrGlamorousTabGroupLook new.

	aTabGroup addTab: (BrTab new
		look: BrGlamorousTabLook new;
		label: 'Tab 1';
		stencil: [ BlElement new
			constraintsDo: [ :c |
				c horizontal exact: 300.
				c vertical matchParent ];
			margin: (BlInsets all: 10);
			background: (Color red alpha: 0.2) ]).
		
	aTabGroup addTab: (BrTab new
		look: BrGlamorousTabLook new;
		label: 'Tab 2';
		stencil: [ BlElement new
			margin: (BlInsets all: 10);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			background: (Color blue alpha: 0.2) ]).
		
	aTabGroup addTab: (BrTab new
		look: BrGlamorousTabLook new;
		label: 'Tab 3';
		stencil: [ BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 300 ];
			margin: (BlInsets all: 10);
			background: (Color orange alpha: 0.2) ]).

	^ aTabGroup
]

{ #category : #toolbar }
BrExamplesShowroom >> glamorousToolbar [
	<gtExample>
	<description: 'Toolbar with glamorous look'>
	| aToolbar |
	
	aToolbar := BrToolbar new.
	aToolbar look: BrGlamorousToolbarLook new.
	
	aToolbar addItem: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Button 1').
		
	aToolbar addItem: (BrButton new
		look: BrGlamorousButtonWithIconLook new;
		label: 'Button 2').
	
	aToolbar addItem: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Button 3').
	
	^ aToolbar
]

{ #category : #toggle }
BrExamplesShowroom >> hydraToggle [
	<gtExample>

	^ BrToggle new
		look: BrHydraSwitchRadioLook new
]

{ #category : #toggle }
BrExamplesShowroom >> hydraWithTrackToggle [
	<gtExample>

	^ BrToggle new
		look: BrHydraSwitchWithTrackLook new
]

{ #category : #toggle }
BrExamplesShowroom >> hydraWithoutTrackToggle [
	<gtExample>

	^ BrToggle new
		look: BrHydraSwitchWithoutTrackLook new
]

{ #category : #buttons }
BrExamplesShowroom >> materialButton [
	<gtExample>
	
	^ BrButton new
		look: BrMaterialButtonLook new;
		label: 'Button'
]

{ #category : #buttons }
BrExamplesShowroom >> materialDisabledButton [
	<gtExample>
	
	^ BrButton new
		look: BrMaterialButtonLook new;
		label: 'Disabled';
		disable
]

{ #category : #toggle }
BrExamplesShowroom >> materialIconAndLabelToggle [
	<gtExample>

	^ BrToggle new
		look: BrMaterialToggleWithIconLook + BrMaterialToggleWithLabelLook
]

{ #category : #toggle }
BrExamplesShowroom >> materialIconToggle [
	<gtExample>

	^ BrToggle new
		look: BrMaterialToggleWithIconLook
]

{ #category : #toggle }
BrExamplesShowroom >> materialLabelToggle [
	<gtExample>

	^ BrToggle new
		look: BrMaterialToggleWithLabelLook
]

{ #category : #toggle }
BrExamplesShowroom >> materialReversedToggle [
	<gtExample>

	^ BrToggle new
		look: BrMaterialToggleWithLabelLook + BrMaterialToggleWithIconLook
]

{ #category : #tabs }
BrExamplesShowroom >> materialTabs [
	<gtExample>
	<description: 'Tabs with material look'>
	| aTabGroup |

	aTabGroup := BrTabGroup new.
	aTabGroup look: BrMaterialTabGroupLook new.

	aTabGroup addTab: (BrTab new
		look: BrMaterialTabLook new;
		label: 'Tab 1';
		stencil: [ BlElement new
			constraintsDo: [ :c |
				c horizontal exact: 300.
				c vertical matchParent ];
			margin: (BlInsets all: 10);
			background: (Color red alpha: 0.2) ]).

	aTabGroup addTab: (BrTab new
		look: BrMaterialTabLook new;
		label: 'Tab 2';
		stencil: [ BlElement new
			margin: (BlInsets all: 10);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			background: (Color blue alpha: 0.2) ]).

	aTabGroup addTab: (BrTab new
		look: BrMaterialTabLook new;
		label: 'Tab 3';
		stencil: [ BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 300 ];
			margin: (BlInsets all: 10);
			background: (Color orange alpha: 0.2) ]).

	^ aTabGroup
]

{ #category : #toggle }
BrExamplesShowroom >> materialToggle [
	<gtExample>

	^ BrToggle new
		look: BrMaterialToggleWithIconLook + BrMaterialToggleWithLabelLook
]

{ #category : #toolbar }
BrExamplesShowroom >> materialToolbar [
	<gtExample>
	<description: 'Toolbar with material look'>
	| aToolbar |
	
	aToolbar := BrToolbar new.
	aToolbar look: BrMaterialToolbarLook new.
	
	aToolbar addItem: (BrButton new
		look: BrMaterialButtonLook new;
		label: 'Button 1').

	aToolbar addItem: (BrButton new
		look: BrMaterialButtonLook new;
		label: 'Button 2').
	
	aToolbar addItem: (BrButton new
		look: BrMaterialButtonLook new;
		label: 'Button 3').
	
	^ aToolbar
]

{ #category : #list }
BrExamplesShowroom >> simpleList [
	<gtExample>
	
	^ BrSimpleList new
		display: (Color indexedColors);
		stencil: [ :aColor |
			BlTextElement new
				text: (aColor asString asRopedText foreground: aColor contrastingForegroundColor);
				background: aColor;
				padding: (BlInsets all: 12);
				constraintsDo: [ :c | c horizontal matchParent ] ]
]
