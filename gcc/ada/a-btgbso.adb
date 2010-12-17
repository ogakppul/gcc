------------------------------------------------------------------------------
--                                                                          --
--                         GNAT LIBRARY COMPONENTS                          --
--                                                                          --
--       ADA.CONTAINERS.RED_BLACK_TREES.GENERIC_BOUNDED_SET_OPERATIONS      --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 2004-2010, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- This unit was originally developed by Matthew J Heaney.                  --
------------------------------------------------------------------------------

with System; use type System.Address;

package body Ada.Containers.Red_Black_Trees.Generic_Bounded_Set_Operations is

   -----------------------
   -- Local Subprograms --
   -----------------------

   function Copy (Source : Set_Type) return Set_Type;

   ----------
   -- Copy --
   ----------

   function Copy (Source : Set_Type) return Set_Type is
   begin
      return Target : Set_Type (Source.Length) do
         Assign (Target => Target, Source => Source);
      end return;
   end Copy;

   ----------------
   -- Difference --
   ----------------

   procedure Set_Difference (Target : in out Set_Type; Source : Set_Type) is
      Tgt, Src : Count_Type;

      TN : Nodes_Type renames Target.Nodes;
      SN : Nodes_Type renames Source.Nodes;

   begin
      if Target'Address = Source'Address then
         if Target.Busy > 0 then
            raise Program_Error with
              "attempt to tamper with cursors (container is busy)";
         end if;

         Tree_Operations.Clear_Tree (Target);
         return;
      end if;

      if Source.Length = 0 then
         return;
      end if;

      if Target.Busy > 0 then
         raise Program_Error with
           "attempt to tamper with cursors (container is busy)";
      end if;

      Tgt := Target.First;
      Src := Source.First;
      loop
         if Tgt = 0 then
            return;
         end if;

         if Src = 0 then
            return;
         end if;

         if Is_Less (TN (Tgt), SN (Src)) then
            Tgt := Tree_Operations.Next (Target, Tgt);

         elsif Is_Less (SN (Src), TN (Tgt)) then
            Src := Tree_Operations.Next (Source, Src);

         else
            declare
               X : constant Count_Type := Tgt;
            begin
               Tgt := Tree_Operations.Next (Target, Tgt);

               Tree_Operations.Delete_Node_Sans_Free (Target, X);
               Tree_Operations.Free (Target, X);
            end;

            Src := Tree_Operations.Next (Source, Src);
         end if;
      end loop;
   end Set_Difference;

   function Set_Difference (Left, Right : Set_Type) return Set_Type is
      L_Node : Count_Type;
      R_Node : Count_Type;

      Dst_Node : Count_Type;
      pragma Warnings (Off, Dst_Node);

   begin
      if Left'Address = Right'Address then
         return S : Set_Type (0);  -- Empty set
      end if;

      if Left.Length = 0 then
         return S : Set_Type (0);  -- Empty set
      end if;

      if Right.Length = 0 then
         return Copy (Left);
      end if;

      return Result : Set_Type (Left.Length) do
         L_Node := Left.First;
         R_Node := Right.First;
         loop
            if L_Node = 0 then
               return;
            end if;

            if R_Node = 0 then
               while L_Node /= 0 loop
                  Insert_With_Hint
                    (Dst_Set  => Result,
                     Dst_Hint => 0,
                     Src_Node => Left.Nodes (L_Node),
                     Dst_Node => Dst_Node);

                  L_Node := Tree_Operations.Next (Left, L_Node);
               end loop;

               return;
            end if;

            if Is_Less (Left.Nodes (L_Node), Right.Nodes (R_Node)) then
               Insert_With_Hint
                 (Dst_Set  => Result,
                  Dst_Hint => 0,
                  Src_Node => Left.Nodes (L_Node),
                  Dst_Node => Dst_Node);

               L_Node := Tree_Operations.Next (Left, L_Node);

            elsif Is_Less (Right.Nodes (R_Node), Left.Nodes (L_Node)) then
               R_Node := Tree_Operations.Next (Right, R_Node);

            else
               L_Node := Tree_Operations.Next (Left, L_Node);
               R_Node := Tree_Operations.Next (Right, R_Node);
            end if;
         end loop;
      end return;
   end Set_Difference;

   ------------------
   -- Intersection --
   ------------------

   procedure Set_Intersection
     (Target : in out Set_Type;
      Source : Set_Type)
   is
      Tgt : Count_Type;
      Src : Count_Type;

   begin
      if Target'Address = Source'Address then
         return;
      end if;

      if Target.Busy > 0 then
         raise Program_Error with
           "attempt to tamper with cursors (container is busy)";
      end if;

      if Source.Length = 0 then
         Tree_Operations.Clear_Tree (Target);
         return;
      end if;

      Tgt := Target.First;
      Src := Source.First;
      while Tgt /= 0
        and then Src /= 0
      loop
         if Is_Less (Target.Nodes (Tgt), Source.Nodes (Src)) then
            declare
               X : constant Count_Type := Tgt;
            begin
               Tgt := Tree_Operations.Next (Target, Tgt);

               Tree_Operations.Delete_Node_Sans_Free (Target, X);
               Tree_Operations.Free (Target, X);
            end;

         elsif Is_Less (Source.Nodes (Src), Target.Nodes (Tgt)) then
            Src := Tree_Operations.Next (Source, Src);

         else
            Tgt := Tree_Operations.Next (Target, Tgt);
            Src := Tree_Operations.Next (Source, Src);
         end if;
      end loop;

      while Tgt /= 0 loop
         declare
            X : constant Count_Type := Tgt;
         begin
            Tgt := Tree_Operations.Next (Target, Tgt);

            Tree_Operations.Delete_Node_Sans_Free (Target, X);
            Tree_Operations.Free (Target, X);
         end;
      end loop;
   end Set_Intersection;

   function Set_Intersection (Left, Right : Set_Type) return Set_Type is
      L_Node : Count_Type;
      R_Node : Count_Type;

      Dst_Node : Count_Type;
      pragma Warnings (Off, Dst_Node);

   begin
      if Left'Address = Right'Address then
         return Copy (Left);
      end if;

      return Result : Set_Type (Count_Type'Min (Left.Length, Right.Length)) do
         L_Node := Left.First;
         R_Node := Right.First;
         loop
            if L_Node = 0 then
               return;
            end if;

            if R_Node = 0 then
               return;
            end if;

            if Is_Less (Left.Nodes (L_Node), Right.Nodes (R_Node)) then
               L_Node := Tree_Operations.Next (Left, L_Node);

            elsif Is_Less (Right.Nodes (R_Node), Left.Nodes (L_Node)) then
               R_Node := Tree_Operations.Next (Right, R_Node);

            else
               Insert_With_Hint
                 (Dst_Set  => Result,
                  Dst_Hint => 0,
                  Src_Node => Left.Nodes (L_Node),
                  Dst_Node => Dst_Node);

               L_Node := Tree_Operations.Next (Left, L_Node);
               R_Node := Tree_Operations.Next (Right, R_Node);
            end if;
         end loop;
      end return;
   end Set_Intersection;

   ---------------
   -- Is_Subset --
   ---------------

   function Set_Subset
     (Subset : Set_Type;
      Of_Set : Set_Type) return Boolean
   is
      Subset_Node : Count_Type;
      Set_Node    : Count_Type;

   begin
      if Subset'Address = Of_Set'Address then
         return True;
      end if;

      if Subset.Length > Of_Set.Length then
         return False;
      end if;

      Subset_Node := Subset.First;
      Set_Node    := Of_Set.First;
      loop
         if Set_Node = 0 then
            return Subset_Node = 0;
         end if;

         if Subset_Node = 0 then
            return True;
         end if;

         if Is_Less (Subset.Nodes (Subset_Node), Of_Set.Nodes (Set_Node)) then
            return False;
         end if;

         if Is_Less (Of_Set.Nodes (Set_Node), Subset.Nodes (Subset_Node)) then
            Set_Node := Tree_Operations.Next (Of_Set, Set_Node);
         else
            Set_Node := Tree_Operations.Next (Of_Set, Set_Node);
            Subset_Node := Tree_Operations.Next (Subset, Subset_Node);
         end if;
      end loop;
   end Set_Subset;

   -------------
   -- Overlap --
   -------------

   function Set_Overlap (Left, Right : Set_Type) return Boolean is
      L_Node : Count_Type;
      R_Node : Count_Type;

   begin
      if Left'Address = Right'Address then
         return Left.Length /= 0;
      end if;

      L_Node := Left.First;
      R_Node := Right.First;
      loop
         if L_Node = 0
           or else R_Node = 0
         then
            return False;
         end if;

         if Is_Less (Left.Nodes (L_Node), Right.Nodes (R_Node)) then
            L_Node := Tree_Operations.Next (Left, L_Node);

         elsif Is_Less (Right.Nodes (R_Node), Left.Nodes (L_Node)) then
            R_Node := Tree_Operations.Next (Right, R_Node);

         else
            return True;
         end if;
      end loop;
   end Set_Overlap;

   --------------------------
   -- Symmetric_Difference --
   --------------------------

   procedure Set_Symmetric_Difference
     (Target : in out Set_Type;
      Source : Set_Type)
   is
      Tgt : Count_Type;
      Src : Count_Type;

      New_Tgt_Node : Count_Type;
      pragma Warnings (Off, New_Tgt_Node);

   begin
      if Target.Busy > 0 then
         raise Program_Error with
           "attempt to tamper with cursors (container is busy)";
      end if;

      if Target'Address = Source'Address then
         Tree_Operations.Clear_Tree (Target);
         return;
      end if;

      Tgt := Target.First;
      Src := Source.First;
      loop
         if Tgt = 0 then
            while Src /= 0 loop
               Insert_With_Hint
                 (Dst_Set  => Target,
                  Dst_Hint => 0,
                  Src_Node => Source.Nodes (Src),
                  Dst_Node => New_Tgt_Node);

               Src := Tree_Operations.Next (Source, Src);
            end loop;

            return;
         end if;

         if Src = 0 then
            return;
         end if;

         if Is_Less (Target.Nodes (Tgt), Source.Nodes (Src)) then
            Tgt := Tree_Operations.Next (Target, Tgt);

         elsif Is_Less (Source.Nodes (Src), Target.Nodes (Tgt)) then
            Insert_With_Hint
              (Dst_Set  => Target,
               Dst_Hint => Tgt,
               Src_Node => Source.Nodes (Src),
               Dst_Node => New_Tgt_Node);

            Src := Tree_Operations.Next (Source, Src);

         else
            declare
               X : constant Count_Type := Tgt;
            begin
               Tgt := Tree_Operations.Next (Target, Tgt);

               Tree_Operations.Delete_Node_Sans_Free (Target, X);
               Tree_Operations.Free (Target, X);
            end;

            Src := Tree_Operations.Next (Source, Src);
         end if;
      end loop;
   end Set_Symmetric_Difference;

   function Set_Symmetric_Difference
     (Left, Right : Set_Type) return Set_Type
   is
      L_Node : Count_Type;
      R_Node : Count_Type;

      Dst_Node : Count_Type;
      pragma Warnings (Off, Dst_Node);

   begin
      if Left'Address = Right'Address then
         return S : Set_Type (0);  -- Empty set
      end if;

      if Right.Length = 0 then
         return Copy (Left);
      end if;

      if Left.Length = 0 then
         return Copy (Right);
      end if;

      return Result : Set_Type (Left.Length + Right.Length) do
         L_Node := Left.First;
         R_Node := Right.First;
         loop
            if L_Node = 0 then
               while R_Node /= 0 loop
                  Insert_With_Hint
                    (Dst_Set  => Result,
                     Dst_Hint => 0,
                     Src_Node => Right.Nodes (R_Node),
                     Dst_Node => Dst_Node);

                  R_Node := Tree_Operations.Next (Right, R_Node);
               end loop;

               return;
            end if;

            if R_Node = 0 then
               while L_Node /= 0 loop
                  Insert_With_Hint
                    (Dst_Set  => Result,
                     Dst_Hint => 0,
                     Src_Node => Left.Nodes (L_Node),
                     Dst_Node => Dst_Node);

                  L_Node := Tree_Operations.Next (Left, L_Node);
               end loop;

               return;
            end if;

            if Is_Less (Left.Nodes (L_Node), Right.Nodes (R_Node)) then
               Insert_With_Hint
                 (Dst_Set  => Result,
                  Dst_Hint => 0,
                  Src_Node => Left.Nodes (L_Node),
                  Dst_Node => Dst_Node);

               L_Node := Tree_Operations.Next (Left, L_Node);

            elsif Is_Less (Right.Nodes (R_Node), Left.Nodes (L_Node)) then
               Insert_With_Hint
                 (Dst_Set  => Result,
                  Dst_Hint => 0,
                  Src_Node => Right.Nodes (R_Node),
                  Dst_Node => Dst_Node);

               R_Node := Tree_Operations.Next (Right, R_Node);

            else
               L_Node := Tree_Operations.Next (Left, L_Node);
               R_Node := Tree_Operations.Next (Right, R_Node);
            end if;
         end loop;
      end return;
   end Set_Symmetric_Difference;

   -----------
   -- Union --
   -----------

   procedure Set_Union (Target : in out Set_Type; Source : Set_Type) is
      Hint : Count_Type := 0;

      procedure Process (Node : Count_Type);
      pragma Inline (Process);

      procedure Iterate is new Tree_Operations.Generic_Iteration (Process);

      -------------
      -- Process --
      -------------

      procedure Process (Node : Count_Type) is
      begin
         Insert_With_Hint
           (Dst_Set  => Target,
            Dst_Hint => Hint,
            Src_Node => Source.Nodes (Node),
            Dst_Node => Hint);
      end Process;

   --  Start of processing for Union

   begin
      if Target'Address = Source'Address then
         return;
      end if;

      if Target.Busy > 0 then
         raise Program_Error with
           "attempt to tamper with cursors (container is busy)";
      end if;

      --  Note that there's no way to decide apriori whether the
      --  target has enough capacity for the union with source.
      --  We cannot simply compare the sum of the existing lengths
      --  to the capacity of the target, because equivalent items
      --  from source are not included in the union.

      Iterate (Source);
   end Set_Union;

   function Set_Union (Left, Right : Set_Type) return Set_Type is
   begin
      if Left'Address = Right'Address then
         return Copy (Left);
      end if;

      if Left.Length = 0 then
         return Copy (Right);
      end if;

      if Right.Length = 0 then
         return Copy (Left);
      end if;

      return Result : Set_Type (Left.Length + Right.Length) do
         Assign (Target => Result, Source => Left);

         Insert_Right : declare
            Hint : Count_Type := 0;

            procedure Process (Node : Count_Type);
            pragma Inline (Process);

            procedure Iterate is
              new Tree_Operations.Generic_Iteration (Process);

            -------------
            -- Process --
            -------------

            procedure Process (Node : Count_Type) is
            begin
               Insert_With_Hint
                 (Dst_Set  => Result,
                  Dst_Hint => Hint,
                  Src_Node => Right.Nodes (Node),
                  Dst_Node => Hint);
            end Process;

         --  Start of processing for Insert_Right

         begin
            Iterate (Right);
         end Insert_Right;
      end return;
   end Set_Union;

end Ada.Containers.Red_Black_Trees.Generic_Bounded_Set_Operations;
