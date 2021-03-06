"
!!Playing with looks 

Let's take a look at a toggle button as an example. A toggle button is made of an element and an associated view model. To have it drawn on the screen, we add a look to it, such as an icon:
${example:BrToggleExamples>>#toogleWithMaterialIcon|expandedPreview=true}$

Or a label:
${example:BrToggleExamples>>#toogleWithMaterialLabel|expandedPreview=true}$

The icon and the label can also be combined:
${example:BrToggleExamples>>#toggleWithMaterialIconAndLabel|expandedPreview=true}$

Changing the order of composition can also affect the rendering. In this case, the icon appears to the right of the label:
${example:BrToggleExamples>>#toggleWithMaterialLabelAndIcon|expandedPreview=true}$

But, looks can also influence the behavior of a widget. For example, to change the icon depending of the state of the toggle, we simply make hte look listen to the toggle event and change the icon from the view model:
${example:BrToggleExamples>>#toggleWithMaterialChangingIcon|expandedPreview=true}$

"
Class {
	#name : #BrToggleExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Toggle'
}

{ #category : #'examples - toggle' }
BrToggleExamples >> activatePredefinedToggle [
	<gtExample>
	| aToggle |
	
	aToggle := self predefinedToggle.
	aToggle activate.

	self assert: aToggle isActivated.
	self assert: aToggle viewModel isActivated.
	
	^ aToggle
]

{ #category : #'examples - toggle' }
BrToggleExamples >> changeIconOfThePredefinedToggle [
	<gtExample>
	| aToggle anIcon |
	
	aToggle := self predefinedToggle.
	anIcon := (BlEllipse extent: 10@10) asElement.
	
	aToggle icon: anIcon.
	self assert: aToggle icon equals: anIcon.

	^ aToggle
]

{ #category : #'examples - toggle' }
BrToggleExamples >> changeLabelOfThePredefinedToggle [
	<gtExample>
	| aToggle aLabel |
	
	aToggle := self predefinedToggle.
	aLabel := 'Hello world'.
	
	aToggle label: aLabel.
	self assert: aToggle label equals: aLabel.

	^ aToggle
]

{ #category : #'instance creation' }
BrToggleExamples >> circleIcon [
	<gtExample>
	
	^ BlElement new
		size: 6@6;
		background: Color red;
		geometry: BlEllipse new;
		margin: (BlInsets all: 3)
]

{ #category : #'examples - click' }
BrToggleExamples >> clickOnActivatedPredefinedToggle [
	<gtExample>
	| aToggleElement aToggleModel aToggleDeactivatedEvent |
		
	aToggleElement := self activatePredefinedToggle.
	aToggleModel := aToggleElement viewModel.
	
	aToggleDeactivatedEvent := nil.
	aToggleElement when: BrToggleDeactivatedEvent do: [ :anEvent | aToggleDeactivatedEvent := anEvent copy ].
	
	BlSpace simulateClickOn: aToggleElement.
	
	self assert: aToggleElement isActivated not.
	self assert: aToggleModel isActivated not.
	
	self assert: aToggleDeactivatedEvent isNotNil.
	self assert: aToggleDeactivatedEvent source equals: aToggleModel.
	self assert: aToggleDeactivatedEvent target equals: aToggleElement.
	self assert: aToggleDeactivatedEvent currentTarget equals: aToggleElement.
	self assert: aToggleDeactivatedEvent isConsumed not.
	
	self assert: aToggleDeactivatedEvent toggle equals: aToggleModel.
	
	^ aToggleDeactivatedEvent
]

{ #category : #'examples - click' }
BrToggleExamples >> clickOnDeactivatedPredefinedToggle [
	<gtExample>
	| aToggleElement aToggleModel aToggleActivatedEvent |
	
	aToggleElement := self deactivatePredefinedToggle.
	aToggleModel := aToggleElement viewModel.
	
	aToggleActivatedEvent := nil.
	aToggleElement when: BrToggleActivatedEvent do: [ :anEvent | aToggleActivatedEvent := anEvent copy ].
	
	BlSpace simulateClickOn: aToggleElement.
	
	self assert: aToggleElement isActivated.
	self assert: aToggleModel isActivated.
	
	self assert: aToggleActivatedEvent isNotNil.
	self assert: aToggleActivatedEvent source equals: aToggleModel.
	self assert: aToggleActivatedEvent target equals: aToggleElement.
	self assert: aToggleActivatedEvent currentTarget equals: aToggleElement.
	self assert: aToggleActivatedEvent isConsumed not.
	
	self assert: aToggleActivatedEvent toggle equals: aToggleModel.
	
	^ aToggleActivatedEvent
]

{ #category : #'examples - toggle' }
BrToggleExamples >> deactivatePredefinedToggle [
	<gtExample>
	| aToggle |
	
	aToggle := self activatePredefinedToggle.
	aToggle deactivate.

	self assert: aToggle isActivated not.
	self assert: aToggle viewModel isActivated not.
	
	^ aToggle
]

{ #category : #'examples - print' }
BrToggleExamples >> gtDisplayStringToggleModel [
	<gtExample>
	| aToggleModel aToggleLabel aPrintString |
	
	aToggleModel := self toggleModel.
	aToggleLabel := 'Hello world'.

	aToggleModel label: aToggleLabel.
	aPrintString := aToggleModel gtDisplayString.
	
	self assert: aPrintString equals: aToggleLabel.
	
	^ aPrintString
]

{ #category : #'examples - toggle' }
BrToggleExamples >> predefinedToggle [
	<gtExample>
	| aToggle |

	aToggle := BrToggle new.
	aToggle look: BrIconLook + BrLabelLook + BrLayoutLook linearHorizontal fitContent + BrToggleLook.

	self assert: aToggle isActivated not.
	self assert: aToggle viewModel isActivated not.

	^ aToggle
]

{ #category : #'examples - print' }
BrToggleExamples >> printStringToggleModel [
	<gtExample>
	| aToggleModel aToggleLabel aPrintString |
	
	aToggleModel := self toggleModel.
	aToggleLabel := 'Hello world'.

	aToggleModel label: aToggleLabel.
	aPrintString := aToggleModel printString.
	
	self assert: aPrintString equals: aToggleLabel.
	
	^ aPrintString
]

{ #category : #'examples - toggle' }
BrToggleExamples >> setActivatedOfPredefinedToggle [
	<gtExample>
	| aToggle |
	
	aToggle := self predefinedToggle.
	aToggle activated: true.

	self assert: aToggle isActivated.
	self assert: aToggle viewModel isActivated.
	
	^ aToggle
]

{ #category : #'examples - toggle' }
BrToggleExamples >> setDeactivatedOfPredefinedToggle [
	<gtExample>
	| aToggle |
	
	aToggle := self activatePredefinedToggle.
	aToggle activated: false.

	self assert: aToggle isActivated not.
	self assert: aToggle viewModel isActivated not.
	
	^ aToggle
]

{ #category : #'instance creation' }
BrToggleExamples >> squareIcon [
	<gtExample>
	
	^ BlElement new
		size: 6@6;
		background: Color blue;
		margin: (BlInsets all: 3)
]

{ #category : #'examples - toggle' }
BrToggleExamples >> toggleActivatedPredefinedToggle [
	<gtExample>
	| aToggle |
	
	aToggle := self activatePredefinedToggle.
	aToggle toggle.

	self assert: aToggle isActivated not.
	self assert: aToggle viewModel isActivated not.
	
	^ aToggle
]

{ #category : #'instance creation' }
BrToggleExamples >> toggleButton [
	<gtExample>
	
	^ self toggleElement viewModel: self toggleModel
]

{ #category : #'instance creation' }
BrToggleExamples >> toggleButtonIcon [
	<gtExample>
	
	^ self circleIcon
		background: Color red
]

{ #category : #'examples - toggle' }
BrToggleExamples >> toggleDeactivatedPredefinedToggle [
	<gtExample>
	| aToggle |
	
	aToggle := self deactivatePredefinedToggle.
	aToggle toggle.

	self assert: aToggle isActivated.
	self assert: aToggle viewModel isActivated.
	
	^ aToggle
]

{ #category : #'instance creation' }
BrToggleExamples >> toggleElement [
	<gtExample>
	
	^ BlElement new
		relocate: 10@10
]

{ #category : #'instance creation' }
BrToggleExamples >> toggleModel [
	<gtExample>
	
	^ BrToggleModel new
]

{ #category : #'examples - material' }
BrToggleExamples >> toggleWithMaterialChangingIcon [
	<gtExample>
	^ self toggleButton
		look: (BrMaterialToggleLabelledLook + BrMaterialToggleIconifiedLook
			when: BrToggleActivatedEvent do: [ :anEvent | 
				anEvent currentTarget widget viewModel icon: self squareIcon ];
			when: BrToggleDeactivatedEvent do: [ :anEvent | 
				anEvent currentTarget widget viewModel icon: self circleIcon ])
]

{ #category : #'examples - material' }
BrToggleExamples >> toggleWithMaterialIconAndLabel [
	<gtExample>
	^ self toggleButton
		look: BrMaterialToggleIconifiedLook + BrMaterialToggleLabelledLook;
		viewModelDo: [ :aModel | aModel icon: self toggleButtonIcon ]
]

{ #category : #'examples - material' }
BrToggleExamples >> toggleWithMaterialLabelAndIcon [
	<gtExample>
	^ self toggleButton
		look: BrMaterialToggleLabelledLook + BrMaterialToggleIconifiedLook;
		viewModelDo: [ :aModel | aModel icon: self toggleButtonIcon ]
]

{ #category : #'examples - material' }
BrToggleExamples >> toogleWithMaterialIcon [
	<gtExample>
	^ self toggleButton
		look: BrMaterialToggleIconifiedLook new;
		viewModelDo: [ :aModel | aModel icon: self toggleButtonIcon ]
]

{ #category : #'examples - material' }
BrToggleExamples >> toogleWithMaterialLabel [
	<gtExample>
	^ self toggleButton
		look: BrMaterialToggleLabelledLook new
]
