Class {
	#name : #BrSimpleListExamples,
	#superclass : #Object,
	#category : 'Brick-Examples-List'
}

{ #category : #'examples - selection' }
BrSimpleListExamples >> exampleWithSelection [
	<gtExample>
	| aList |
	aList := BrSimpleList new.
	aList
		stencil: [ :each :index |
			BlTextElement new
				text: each key asRopedText;
				constraintsDo: [ :c | c horizontal matchParent ];
				padding: (BlInsets all: 5);
				when: BlClickEvent do: [ :anEvent  |
					anEvent consumed: true.
					aList selectOne: index ] ];
		display: (Smalltalk ui icons icons associations);
		when: BrSelectionChanged do: [ :anEvent |
			anEvent selectedDo: [ :anInterval | self inform: 'Selected: ', anInterval asString ].
			anEvent deselectedDo: [ :anInterval | self inform: 'Deselected: ', anInterval asString ] ];
		yourself.
	^ aList
]

{ #category : #'examples - list' }
BrSimpleListExamples >> listAllClasses [
	<gtExample>
	| aListElement aListLook aListModel |

	aListElement := self listElement.

	aListModel := self listModel.
	aListModel items: Smalltalk allClasses.

	aListLook := self listLook.	
	aListElement look: aListLook.
	aListElement viewModel: aListModel.

	^ aListElement
]

{ #category : #'examples - instance creation' }
BrSimpleListExamples >> listElement [
	<gtExample>

	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 500.
			c vertical matchParent ]
]

{ #category : #'examples - instance creation' }
BrSimpleListExamples >> listLook [
	<gtExample>
	
	^ BrSimpleListLook new
]

{ #category : #'examples - instance creation' }
BrSimpleListExamples >> listModel [
	<gtExample>
	
	^ BrSimpleListModel new
]

{ #category : #'examples - material' }
BrSimpleListExamples >> singleLineWithTinyIcon [
	<gtExample>

	^ BrSimpleList new
		stencil: [ :each :index |			
			BrMaterialListItemStencil singleLineWithTinyIcon
				label: each key asString;
				icon: (BlScalableElement new contentElement: (BlElement new background: each value; size: each value extent)) ];
		display: (Smalltalk ui icons icons associations)
]
