Class {
	#name : #BrTextEditorLineSplitterExamples,
	#superclass : #Object,
	#category : 'Brick-Editor-Examples'
}

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_Cr [
	<gtExample>
	| aText aSplitter aStream |

	aText := String cr asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aText in: aStream.

	self assert: aStream segments size equals: 2.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 0.
	
	self assert: aStream segments second textStart equals: 1.
	self assert: aStream segments second textEnd equals: 1.

	^ aStream
]

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_CrCr [
	<gtExample>
	| aText aSplitter aStream |

	aText := (String cr, String cr) asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aText in: aStream.

	self assert: aStream segments size equals: 3.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 0.
	
	self assert: aStream segments second textStart equals: 1.
	self assert: aStream segments second textEnd equals: 1.
	
	self assert: aStream segments third textStart equals: 2.
	self assert: aStream segments third textEnd equals: 2.

	^ aStream
]

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_CrLf [
	<gtExample>
	| aText aSplitter aStream |

	aText := (String cr, String lf) asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aText in: aStream.

	self assert: aStream segments size equals: 2.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 0.
	
	self assert: aStream segments second textStart equals: 2.
	self assert: aStream segments second textEnd equals: 2.

	^ aStream
]

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_CrLfCrLf [
	<gtExample>
	| aText aSplitter aStream |

	aText := (String cr, String lf, String cr, String lf) asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aText in: aStream.

	self assert: aStream segments size equals: 3.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 0.
	
	self assert: aStream segments second textStart equals: 2.
	self assert: aStream segments second textEnd equals: 2.
	
	self assert: aStream segments third textStart equals: 4.
	self assert: aStream segments third textEnd equals: 4.

	^ aStream
]

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_CraCrLfbLf [
	<gtExample>
	| aText aSplitter aStream |

	aText := (String cr, 'a', String cr, String lf, 'b', String lf) asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aText in: aStream.

	self assert: aStream segments size equals: 4.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 0.
	
	self assert: aStream segments second textStart equals: 1.
	self assert: aStream segments second textEnd equals: 2.
	
	self assert: aStream segments third textStart equals: 4.
	self assert: aStream segments third textEnd equals: 5.
	
	self assert: aStream segments fourth textStart equals: 6.
	self assert: aStream segments fourth textEnd equals: 6.

	^ aStream
]

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_Hello [
	<gtExample>
	| aText aSplitter aStream |

	aText := 'Hello' asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aText in: aStream.

	self assert: aStream segments size equals: 1.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 5.

	^ aStream
]

{ #category : #'examples - split subtext' }
BrTextEditorLineSplitterExamples >> split_Hello_from_HabaHelloFoo [
	<gtExample>
	| aText aSubText aSplitter aStream |

	aText := 'HabaHelloFoo' asRopedText.
	aSubText := aText from: 5 to: 9.
	
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aSubText in: aStream.

	self assert: aStream segments size equals: 1.
	self assert: aStream segments first textStart equals: 4.
	self assert: aStream segments first textEnd equals: 9.

	^ aStream
]

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_a [
	<gtExample>
	| aText aSplitter aStream |

	aText := ('a') asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aText in: aStream.

	self assert: aStream segments size equals: 1.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 1.

	^ aStream
]

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_empty [
	<gtExample>
	| aText aSplitter aStream |

	aText := '' asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.
	
	aSplitter split: aText in: aStream.
	
	self assert: aStream segments size equals: 1.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 0.

	^ aStream
]

{ #category : #'examples - split' }
BrTextEditorLineSplitterExamples >> split_haCrCrbaCr [
	<gtExample>
	| aText aSplitter aStream |

	aText := ('ha', String cr, String cr, 'ba', String cr) asRopedText.
	aSplitter := self textLineSplitter.
	aStream := self textSegmentStream.

	aSplitter split: aText in: aStream.

	self assert: aStream segments size equals: 4.
	self assert: aStream segments first textStart equals: 0.
	self assert: aStream segments first textEnd equals: 2.
	
	self assert: aStream segments second textStart equals: 3.
	self assert: aStream segments second textEnd equals: 3.
	
	self assert: aStream segments third textStart equals: 4.
	self assert: aStream segments third textEnd equals: 6.
	
	self assert: aStream segments fourth textStart equals: 7.
	self assert: aStream segments fourth textEnd equals: 7.

	^ aStream
]

{ #category : #'examples - instance creation' }
BrTextEditorLineSplitterExamples >> textLineSplitter [
	<gtExample>

	^ BrTextEditorLineSplitter new
]

{ #category : #'examples - instance creation' }
BrTextEditorLineSplitterExamples >> textSegmentStream [
	<gtExample>

	^ BrEditorSegmentStream new
]
