Class {
	#name : #BrGlamorousProgressWithBarAndLabelLook,
	#superclass : #BrLook,
	#category : #'Brick-Glamorous-Progress'
}

{ #category : #initialization }
BrGlamorousProgressWithBarAndLabelLook >> initialize [
	super initialize.
	
	self addChangeProperty: #(widget layout) with: [ BlLinearLayout vertical ].
	self addChangeProperty: #(widget constraints horizontal resizer) with: [ BlLayoutResizer matchParent ].
	self addChangeProperty: #(widget constraints vertical resizer) with: [ BlLayoutResizer fitContent ].
	
	self addAll: {
		BrGlamorousProgressBarLook new.
		BrGlamorousProgressLabelLook new.
	}
]