module Bonanza.Anon
    ( anonymise
    )
where

import Bonanza.Types
import Control.Lens        ((%~), (&), _Wrapped', over)
import Data.HashMap.Strict (filterWithKey)
import Data.Text           (Text)


anonymise :: [Text] -> LogEvent -> LogEvent
anonymise [] evt = evt
anonymise ts evt = evt & logTags %~ stripTags
  where
    stripTags = over _Wrapped' (filterWithKey (\ k _ -> not (k `elem` ts)) )
{-# INLINABLE anonymise #-}
