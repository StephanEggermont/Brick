Class {
	#name : #BrTab,
	#superclass : #BlElement,
	#instVars : [
		'labelModel',
		'iconModel'
	],
	#category : 'Brick-Tabs - UI'
}

{ #category : #'api - accessing' }
BrTab >> actionsStencil: aStencilBuilder [
	self viewModel actionsStencil: aStencilBuilder
]

{ #category : #'api - accessing' }
BrTab >> icon: anElement [
	iconModel icon: anElement
]

{ #category : #initialization }
BrTab >> initialize [
	super initialize.

	self viewModel: (BrTabModel new + 
		(labelModel := BrLabelModel new) +
		(iconModel := BrIconModel new))
]

{ #category : #'api - accessing' }
BrTab >> label: aStringOrText [
	labelModel text: aStringOrText
]

{ #category : #accessing }
BrTab >> parentTabGroup [
	^ self 
		allParentsDetect: [ :aParent | aParent isKindOf: BrTabGroup ]
		ifFound: [ :aParent | aParent ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
BrTab >> stencil: aStencilBuilder [
	self viewModel stencil: aStencilBuilder
]
